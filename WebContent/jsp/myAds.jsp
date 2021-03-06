<%@page import="java.io.IOException"%>
<%@page import="javax.xml.bind.DatatypeConverter"%>
<%@page import="java.io.File"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.io.ByteArrayOutputStream"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="bean.Address"%>
<%@page import="java.util.List"%>
<%@page import="service.UserService"%>
<%@page import="bean.User"%>
<%@page import="java.util.Map"%>
<%@page import="bean.Category"%>
<%@page import="java.util.HashMap"%>
<%@page import="dbutil.CacheHandler"%>
<%@ include file="htmlHead.jsp" %>
<%@ include file="pageHeader.jsp" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="js/myAds.js"></script>
 <link href="css/myAds.css" rel="stylesheet">

<section id="cart_items">
<%
UserService service = new UserService();
/* User u = service.getUser("rohanborde9@gmail.com");
session.setAttribute("user", u); */
User user = (User) session.getAttribute("user");
if(user == null || user.getEmail() == null || user.getEmail().isEmpty()) {
	//System.out.println("dddddddddddddddddddddddddddddddddddddddddddd");
	response.sendRedirect("login");
} else {
System.out.println(user);
   HashMap<Integer, Category> categories = CacheHandler.getCategories();
   HashMap<Integer, String> conditions = CacheHandler.getItemConditions();
   List<Address> addresses = service.getUserAddresses(user.getId());
   
%>

		<div class="container">
			<div class="step-one">
				<h2 class="heading" style = "background: none repeat scroll 0 0 #a8cecc">Submit a Free Classified Ad </h2>
			</div>
			<div id = "errorDiv0" style = "    margin-left: 39px;"></div>
			<div id = "adBody" class="shopper-informations">
				<div class="row">
				
					<div class="col-sm-6">
						<div class="shopper-info">
							<p>Advertisement Info</p>
							<form>
								<input type="text" id ="title" name="title" placeholder="Ad Title">
								<select placeholder="Category" id ="category" name ="category">
								<% 
									for(Integer id: CacheHandler.getArrangedCategories().keySet()) {
								%>
										<option value="<%=id%>"><%=CacheHandler.getCategory(id).getName()%></option>
								<%}	%>	
								</select><br></br>
								
								<select placeholder="subCategory" id ="subCategory" name ="subcategory">
								
								</select><br></br>
								
								<input type="text" name="price" id ="price" placeholder="Price">
								<label>Price Negotiable?</label>
									<div><input type="radio" class ="isNegotiable" style ="margin-left: 10px; margin-right: 20px;" name="isNegotiable" value ="true"  checked/><span>YES</span></div>
									<div><input type="radio" class ="isNegotiable" style ="margin-left: 10px; margin-right: 20px;" name="isNegotiable" value ="false"/><span>NO</span></div>
								
								<select placeholder="Condition" id ="condition" name ="condition">
								<% for(Map.Entry<Integer, String> entry : conditions.entrySet()) {
									String itemcondition = entry.getValue();
								%>
										<option value="<%=itemcondition%>"><%=itemcondition%></option>
								<%}	%>	
								</select><br></br>
								<textarea name="description" id ="description" placeholder="Describe the ad in detail." rows="16"></textarea>
								</form>
							<br></br>
						
						</div>
					</div>
					<div class="col-sm-6">
								<div class="shopper-info">
								<p>My Info</p>
								<form>
									<input type="text"  id ="contactNumber" placeholder="Phone" name="contactNumber">
									<br>
									<label>Display Contact Number?</label>
									 <div><input type="radio" class ="displayContactNumber" name="displayContactNumber" value ="true" style ="margin-left: 10px; margin-right: 20px;" checked/><span>YES</span></div>
									 <div><input type="radio" class ="displayContactNumber" name="displayContactNumber" style ="margin-left: 10px; margin-right: 20px;" value ="false"/><span>NO</span></div>
									
								</form>
								<br></br>
								<p>Image Info</p>
								<form id="uploadForm" action="UploadServlet" method="post" enctype="multipart/form-data">
								    <input class="btn btn-primary custom_addclass" id="uploadPhoto" style = "background: #aab8b7" type="file" name="photo"  />
								    <input class="btn btn-primary custom_addclass" id="uploadImageBtn" style = "background: #819998" type="submit" value="Upload Image" />
								</form>
								
							</div>	
					</div>	
					</form>
								
				</div>
			</div>
			<div class="review-payment custom_addclass">
				<h2 style = "margin-top: 45px; margin-bottom: 20px;">Select Address</h2>
			</div>
			
		   <div id = "errorDiv3" style = " margin-left: 39px;"></div>
			<div class="table-responsive cart_info custom_addclass" style = "margin-bottom: 0px;" >
				<table class="table table-condensed">
					<thead>
						<tr class="cart_menu" style = " background: #b1c0bf;">
							<td class="image">Address</td>
							<td class="description"></td>
							<td class="price">City</td>
							<td class="total">ZipCode</td>
							<td></td>
						</tr>
					</thead>
					<tbody id="table_body">
						<% 
						for(Address address : addresses) {
						%>
						<tr>
							<td class="cart_product">
								<input type="radio" name="add1" class="checkboxAdd" value="<%=address.getId()%>" checked> <br>
							</td>
							<td class="cart_description">
								<h4><a href=""><%=address.getAddress()%></a></h4>
								<p><%=address.getState()%> & <%=address.getCountry()%></p>
							</td>
							<td class="cart_price">
								<p><%=address.getCity()%></p>
							</td>
							<td class="cart_price">
								<p><%=address.getZipcode()%></p>
							</td>
							
							<td class="cart_delete">
								<a class="cart_quantity_delete" onclick="$(this).removeAddress(<%=address.getId()%>);"><i class="fa fa-times"></i></a>
							</td>
						</tr>
						<%} %>
						
					</tbody>
					
				</table>
			</div>
			</br>
			<a id = "newAddButton" class="btn btn-default custom_addclass">Add New Address</a>
			<br></br>
			<div id = "errorDiv" style = " margin-left: 39px;"></div>
			<div id = "addAddressDiv" class="shopper-informations custom_newaddclass"  >
				<div class="row">
					<div class="col-sm-9 custom_addressform">
						<div class="shopper-info">
							<p>New Address Info</p>
							<form id= "addForm">
								<input type="text" id="address" placeholder="Address"> <br>
								<input type="text" id="state" placeholder="State"> <br>
								<input type="text" id="country" placeholder="Country"> <br>
								<input type="text" id="city" placeholder="City">
								<input type="text" id="zipcode" placeholder="Zip Code">
							</form>
							<button id = "saveButton" class="btn btn-primary custom_addclass" style = "background: #698f8d">Save</button>
						</div>
					</div>
								
				</div>
			</div>
			
				<a id="postAddBtn" class="btn btn-primary custom_addclass" style = "background: #698f8d" >Post Ad</a>
				<a class="btn btn-primary custom_addclass" style = "background: #698f8d" href="/">Cancel</a>
		</div>
	</section> <!--/#cart_items-->
<br></br><br></br>
<%} %>
<!--/form-->
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery-form-validator/2.3.26/jquery.form-validator.min.js"></script>
<script>
  $.validate({
    modules : 'security'
  });
</script>
<%@ include file="pageFooter.jsp" %>