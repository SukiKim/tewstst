<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="javax.xml.parsers.*" %>
<%@page import="org.w3c.dom.*" %>
<%@page import="org.xml.sax.SAXException" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Simple Map</title>
<meta name="viewport" content="initial-scale=1.0">
<meta charset="utf-8">
<style>
/* Always set the map height explicitly to define the size of the div
       * element that contains the map. */
#map {
	height: 100%;
}
/* Optional: Makes the sample page fill the window. */
html, body {
	height: 100%;
	margin: 0;
	padding: 0;
}
</style>
</head>
<body>
	<%
			String start = "http://ws.bus.go.kr/api/rest/buspos/getBusPosByRtid";
			String serviceKey = "k%2Bk4jA4S%2BksyRHx9fYl1CxhdytThMDqWbI37KlS0jC42bpq2Wyhg2%2FWXp27N66jYD%2FUkmJIMKY93hb9RsJv9Uw%3D%3D";
			String busid = "100100086";
			String url = start + "?ServiceKey=" + serviceKey + "&busRouteId=" + busid;

			DocumentBuilderFactory dbFactoty = DocumentBuilderFactory.newInstance();
			DocumentBuilder dBuilder = dbFactoty.newDocumentBuilder();
			Document doc = dBuilder.parse(url);
			
			ArrayList<ArrayList<String>> second = new ArrayList<ArrayList<String>>();
			/* out.println(url); */
			// root tag
			doc.getDocumentElement().normalize();
			NodeList nList = doc.getElementsByTagName("itemList");
			
			for(int temp = 0; temp<nList.getLength(); temp++) {
				
				Node nNode = nList.item(temp);
				Element eElement = (Element) nNode;
				
				ArrayList<String> child = new ArrayList<String>();
				
				child.add(eElement.getElementsByTagName("busType").item(0).getChildNodes().item(0).getNodeValue());
				child.add(eElement.getElementsByTagName("dataTm").item(0).getChildNodes().item(0).getNodeValue());
				child.add(eElement.getElementsByTagName("gpsX").item(0).getChildNodes().item(0).getNodeValue());
				child.add(eElement.getElementsByTagName("gpsY").item(0).getChildNodes().item(0).getNodeValue());
				child.add(eElement.getElementsByTagName("plainNo").item(0).getChildNodes().item(0).getNodeValue());
				
				
				second.add(child);
				
			}
			 		
		%>
	

	<div id="map"></div>

	<script>
		
		function initMap() {
			var mylang = new Array();
			var map = new google.maps.Map(document.getElementById('map'), {
				center : {
					lat : 37.566583,
					lng : 126.958392
				},
				zoom : 13
			});
		 	 <%
		 	for(int i = 0; i<second.size(); i++){
				Double longi = Double.parseDouble(second.get(i).get(2));
				 Double lati = Double.parseDouble(second.get(i).get(3)); 
				String contentString = second.get(i).get(1) + "\n" + second.get(i).get(4);
			%>
			var myLatlng = new google.maps.LatLng(<%=lati%>, <%=longi%>);	//반복문을 이용한 다중마커 찍기
			
			 var marker = new google.maps.Marker({ 
			      position: myLatlng,
			        map: map,
			    });
		   <%}%>
		}	
			
	</script>

 	<script
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCR91IgK9tdWoGNWKhKjZlmJiGPuwab5Bw&callback=initMap"
		async defer></script> 


	<!--
		API 키 입력 해야한다.	
	 <script
	src="https://maps.googleapis.com/maps/api/js?key=자신의 API 키 &callback=initMap"
	async defer>		
		</script> -->

</body>
</html>

