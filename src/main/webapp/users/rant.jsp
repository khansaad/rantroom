<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">

    <title>RantRoom | New Rant</title>

    <link href="${contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
    <link href="${contextPath}/resources/css/style.css" rel="stylesheet">
    <!--favicons -->
    <link rel="apple-touch-icon" sizes="57x57" href="${contextPath}/resources/favicons/apple-icon-57x57.png">
    <link rel="apple-touch-icon" sizes="60x60" href="${contextPath}/resources/favicons/apple-icon-60x60.png">
    <link rel="apple-touch-icon" sizes="72x72" href="${contextPath}/resources/favicons/apple-icon-72x72.png">
    <link rel="apple-touch-icon" sizes="76x76" href="${contextPath}/resources/favicons/apple-icon-76x76.png">
    <link rel="apple-touch-icon" sizes="114x114" href="${contextPath}/resources/favicons/apple-icon-114x114.png">
    <link rel="apple-touch-icon" sizes="120x120" href="${contextPath}/resources/favicons/apple-icon-120x120.png">
    <link rel="apple-touch-icon" sizes="144x144" href="${contextPath}/resources/favicons/apple-icon-144x144.png">
    <link rel="apple-touch-icon" sizes="152x152" href="${contextPath}/resources/favicons/apple-icon-152x152.png">
    <link rel="apple-touch-icon" sizes="180x180" href="${contextPath}/resources/favicons/apple-icon-180x180.png">
    <link rel="icon" type="image/png" sizes="192x192"  href="${contextPath}/resources/favicons/android-icon-192x192.png">
    <link rel="icon" type="image/png" sizes="32x32" href="${contextPath}/resources/favicons/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="96x96" href="${contextPath}/resources/favicons/favicon-96x96.png">
    <link rel="icon" type="image/png" sizes="16x16" href="${contextPath}/resources/favicons/favicon-16x16.png">
    <link rel="manifest" href="${contextPath}/resources/favicons/manifest.json">
    <meta name="msapplication-TileColor" content="#ffffff">
    <meta name="msapplication-TileImage" content="/ms-icon-144x144.png">
    <meta name="theme-color" content="#ffffff">
    <!--favicons-end -->
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
    <body>
        <header id="header">
            <nav class="navbar navbar-default">
				<div class="container">
                    <div class="row">
                        <div class="col-sm-3">
                            <div class="navbar-header">
                              <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                                <span class="sr-only">Toggle navigation</span>
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span>
                              </button>
                              <a class="navbar-brand" href="${contextPath}/home"><img class="logo" alt="RantRoom logo" src="${contextPath}/resources/images/rantroomlogo_bl.png" /></a>
                            </div>
                        </div>    
                        <div class="col-sm-9">
                            <div class="row navbar-collapse collapse" id="bs-example-navbar-collapse-1" aria-expanded="false">                                
                                <div class="col-sm-8 menu">    
                                      <ul class="nav navbar-nav">
                                        <li><a href="${contextPath}/home">Home</a></li>
                                        <li></li>
                                        <li><a href="#">Rants</a></li> 
                                        <li class="dropdown">
                                          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Categories <span class="caret"></span></a>
                                            <ul class="dropdown-menu sublist" role="menu">
                                                    <li><a href="#">Politics</a></li>
                                                    <li><a href="#">Technology</a></li>
                                                    <li><a href="#">Sports</a></li>
                                                    <li><a href="#">Social Issues</a></li>
                                                    <li><a href="#">Social Media</a></li>
                                                    <li><a href="#">Work</a></li>
                                                    <li><a href="#">Religion</a></li>
                                            </ul>
                                        </li>
                                        <li class="dropdown">
                                          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">About <span class="caret"></span></a>
                                            <ul class="dropdown-menu sublist" role="menu">
                                                    <li><a href="#">About</a></li>
                                                    <li><a href="#">Rules</a></li> 
                                            </ul>
                                        </li>  
                                      </ul>
                                </div><!--inner col-sm-8--> 
                                <div class="col-sm-4">
                                	<ul class="nav navbar-nav navbar-right menu">
                                      	<c:choose>
                                      		<c:when test="${user != null}">
                                      			<form id="logoutForm" method="POST" action="${contextPath}/logout">
                                    				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                				</form>
	                                            <li class="dropdown">
                                          			<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">${user.getUsername()}<span class="caret"></span></a>
                                           			<ul class="dropdown-menu sublist" role="menu">
	                                                    <li><a href="${contextPath}/users/profile">Profile</a></li>		                                                    
	                                                    <li><a href="${contextPath}/users/profile/settings">Settings</a></li>
	                                                    <li><a onclick="document.forms['logoutForm'].submit()">Logout</a></li> 
                                           			</ul>
                                        		</li>  	                                            
                                        	</c:when>
                                        	<c:otherwise>
                                        		<li><a href="${contextPath}/login">Login</a></li>
	                                            <li><a href="${contextPath}/registration">Sign Up</a></li>
                                        	</c:otherwise>
                                        </c:choose>	    
                                      </ul>    
                                </div><!--inner col-sm-4--> 
                            </div><!--inner-row-->
                        </div><!--outer col-sm-8-->   
                    </div><!--outer-row-->    
                </div><!--container-->
			</nav>
		</header>
        <div id="main">
            <div class="container" id="sub-content">
            	<c:choose>
            	   <c:when test="${rantDesc == null }"> 
                        <div class="row">
                            <div class="col-sm-6">
                                <h3 class="home-h2" style="text-align: left;"> Start Ranting Below</h3>
                            </div>
                            <div class="col-sm-3 col-sm-offset-3 menu">
                                <p style="font-weight: 700"><a href="${contextPath}/users/profile">Cancel</a></p>
                            </div>    
                        </div>
                        <div class="row">
                            <div class="col-md-9">
                                <p style="font-size: 13px;font-weight: 700">Note: Racism and full names are not allowed (except celebs)</p>
                                <form:form method="POST" modelAttribute="rantForm">
                                    <div class="row">
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label>Rant Title</label>
                                                <spring:bind path="rantTitle">
                                                    <div class="form-group ${status.error ? 'has-error' : ''}">
                                                        <form:input type="text" path="rantTitle" class="form-control" autofocus="true"></form:input>
                                                        <form:errors path="rantTitle"></form:errors>
                                                        <span>Give your rant a short descriptive Title.</span>           
                                                    </div>    
                                                </spring:bind>    
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label>Rant</label>
                                        <spring:bind path="rantDesc">
                                            <form:textarea path="rantDesc" class="form-control" required="required" rows="12"></form:textarea>
                                            <form:errors path="rantDesc"></form:errors>                                    
                                        </spring:bind>    
                                    </div> 
                                    <button type="submit" class="btn btn-primary rantsubmit">Submit Your Rant</button>
                                </form:form>
                            </div><!--col-md-9 -->                                       
                        </div><!--row -->
                    </c:when>
                    <c:otherwise>
                        <div class="row">
                        	<c:if test="${rantstatus!=null}">
                        		<br><p style="color: green; font-size:18px; text-align: center;">${rantstatus}</p>
                        	</c:if>
                            <div class="col-sm-6">
                            	<c:choose>
                            		<c:when test="${user != null}">
		                                <h3><a style="text-align: left;font-size: 16px" href="${contextPath}/users/profile" > &lt;&lt;Back</a></h3>                            			
                            		</c:when>
                            		<c:otherwise>
                            			<h3><a style="text-align: left;font-size: 16px" href="${contextPath}/home" > &lt;&lt;Back</a></h3>
                            		</c:otherwise>
                            	</c:choose>
                            </div>
                            <c:if test="${rantDesc.getUser().getId()==user.getId()}">
	                            <div class="col-sm-3 col-sm-offset-3 menu">
	                                <p style="font-weight: 700"><a href="${contextPath}/editrant/${rantDesc.getId()}">Edit</a></p>
	                                <p style="font-weight: 700"><a data-toggle="modal" data-target="#myModal" href="#">Delete</a></p><!-- Add modal here -->
	                                
	                            </div>    
                            </c:if>
                        </div>
                        <div class="rant rant-details rant-sm">
                            <h3 class="rantTitle">${rantDesc.getRantTitle()}</h3>
                            <p class="fa fa-quote-left text-quote-icon text-quote-icon-left" style="margin-bottom: 24px">${rantDesc.getRantDesc()}</p>    
                        </div> 
                    </c:otherwise>
                </c:choose> 
            </div> <!-- /container -->
            <!-- footer -->
            <footer id="footer" class="text-center">
              <div class="container social">

                <div class="col-sm-12">                
                  <a href="#" class="icon-circle fb" target="_blank">
                    <img class="logo" alt="Facebook" src="${contextPath}/resources/social/facebook_transparent-1c6a690dcde061958f50f712404c764613cc193d3f69e81734c8c9a7f36131e4.png" />
                  </a>

                  <a href="#" class="icon-circle tw" target="_blank">
                    <img class="logo" alt="Twitter" src="${contextPath}/resources/social/twitter_transparent-39f60ddc31bce0d3e3d6ae72af7fbe74dc95e01b7d7a6f66cc38efabda3bb6da.png" />
                  </a>

                  <a href="#" class="icon-circle gl" target="_blank">
                    <img class="logo" alt="Google Plus" src="${contextPath}/resources/social/gplus_transparent-fab632559c47bada047b0ff2cb7b8880a10836d08db04c7cdae2e3d3abe474e1.png" />
                  </a>

                    <a href="#" class="icon-circle pt" target="_blank">
                    <img class="logo" alt="Pinterest" src="${contextPath}/resources/social/pinterest_transparent-a58a9baa98ec9a2e4fed6d4ab7ffdb69bc607c82649a486544b2b5dab03364ef.png" />
                   </a>
                </div>

              </div><!--social-->

              <p id="copyright">&copy; 2018 Team RantRoom. All rights reserved | Designed by <a href="http://www.khansaad.com/" target="_blank" >Saad </a>| Mentored by <a href="http://www.roosnam.com/" target="_blank" >Mansoor</a></p>
        </footer>
        <!-- The Modal -->
        <div class="modal fade" id="myModal">
                <div class="modal-dialog">
                  <div class="modal-content">					
                    <!-- Modal Header -->
                    <div class="modal-header">
                      <h5 class="modal-title" style="color: #0F6BBA">Delete Rant</h5>
                    </div>

                    <!-- Modal body -->
                    <div class="modal-body">
                        <p>Are you sure you want to delete this rant?</p>
                        <form:form id="deleteRant" method="POST" action="/deleterant/${rantDesc.getId()}">
                            <button style="margin-bottom: 12px" type="submit" class="btn btn-success btn-icon"><i class="fa fa-check-square-o"></i> Delete Rant</button>
	                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                        </form:form>
                    </div>
                  </div>
                </div>
              </div><!-- Modal end -->
        </div>    
        <script src="${contextPath}/resources/js/jquery.min.js"></script>
        <script src="${contextPath}/resources/js/bootstrap.min.js"></script>
    </body>
</html>