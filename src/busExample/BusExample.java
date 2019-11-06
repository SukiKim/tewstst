package busExample;

import java.io.IOException;
import java.util.ArrayList;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

public class BusExample {

	public static void main(String[] args) throws ParserConfigurationException, SAXException, IOException {
		String start = "http://ws.bus.go.kr/api/rest/buspos/getBusPosByRtid";
		String serviceKey = "k%2Bk4jA4S%2BksyRHx9fYl1CxhdytThMDqWbI37KlS0jC42bpq2Wyhg2%2FWXp27N66jYD%2FUkmJIMKY93hb9RsJv9Uw%3D%3D";
		String busid = "100100331";
		String url = start + "?ServiceKey=" + serviceKey + "&busRouteId=" + busid;

		DocumentBuilderFactory dbFactoty = DocumentBuilderFactory.newInstance();
		DocumentBuilder dBuilder = dbFactoty.newDocumentBuilder();
		Document doc = dBuilder.parse(url);
		
		ArrayList<ArrayList<String>> second = new ArrayList<ArrayList<String>>();
		
		// root tag
		doc.getDocumentElement().normalize();
		System.out.println("Root element: " + doc.getDocumentElement().getNodeName()); // Root element: result
		NodeList nList = doc.getElementsByTagName("itemList");
		System.out.println("파싱할 리스트 수 : "+ nList.getLength());
		
		for(int temp = 0; temp<nList.getLength(); temp++) {
			
			Node nNode = nList.item(temp);
			Element eElement = (Element) nNode;
			
			ArrayList<String> child = new ArrayList<String>();
			
			child.add(getTagValue("busType", eElement));
			child.add(getTagValue("dataTm", eElement));
			child.add(getTagValue("gpsX", eElement));
			child.add(getTagValue("gpsY", eElement));
			child.add(getTagValue("plainNo", eElement));
			
			second.add(child);
			
		}
		System.out.println(second.get(0).get(4));
		
		  



	}

	private static String getTagValue(String tag, Element eElement) {
		NodeList nlList = eElement.getElementsByTagName(tag).item(0).getChildNodes();
	    Node nValue = (Node) nlList.item(0);
	    if(nValue == null) 
	        return null;
	    return nValue.getNodeValue();


	}
}
