<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> <%-- imports function tags from JSTL, prefix "fn"--%>
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

    <title>RantRoom | ${user.getFirstname()}</title>

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
                              <a class="navbar-brand" href="../home"><img class="logo" alt="RantRoom logo" src="${contextPath}/resources/images/rantroomlogo_bl.png" /></a>
                            </div>
                        </div>    
                        <div class="col-sm-9">
                            <div class="row navbar-collapse collapse menu" id="bs-example-navbar-collapse-1" aria-expanded="false">                                
                                <div class="col-sm-8">    
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
                                	<ul class="nav navbar-nav navbar-right">
                                      	<c:choose>
                                      		<c:when test="${user != null}">
	                                            <li class="dropdown">
                                          			<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">${user.getUsername()}<span class="caret"></span></a>
                                            			<ul class="dropdown-menu sublist" role="menu">
		                                                    <li><a href="${contextPath}/users/profile">Profile</a></li>		                                                    
		                                                    <li><a href="${contextPath}/users/profile/settings">Settings</a></li>
		                                                    <li><a onclick="document.forms['logoutForm'].submit()">Logout</a></li> 
                                            			</ul>
									                    <form id="logoutForm" method="POST" action="${contextPath}/logout">
									                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
									                    </form>
                                        		</li>  	                                            
                                      			<form id="logoutForm" method="POST" action="${contextPath}/logout">
                                    				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                				</form>
                                        	</c:when>
                                        	<c:otherwise>
                                        		<li><a href="${contextPath}/login">Login</a></li>
	                                            <li><a class="home-links" href="${contextPath}/registration">Sign Up</a></li>
                                        	</c:otherwise>
                                        </c:choose>	    
                                      </ul>                                       
                                      <!-- <ul class="nav navbar-nav navbar-right">
                                            <li><a data-toggle="modal" data-target="#myModal" href="#">Delete Account</a></li>
                                           <li><a class="home-links" href="${contextPath}/registration">Sign Up</a></li>
                                      </ul> -->     
                                </div><!--inner col-sm-4--> 
                            </div><!--inner-row-->
                        </div><!--outer col-sm-9-->   
                    </div><!--outer-row-->    
                </div><!--container-->
			</nav>
		</header>
        <div id="main">
	        <c:choose>
	          <c:when test="${info == null}">
	            <div class="container" id="sub-content">
	                <div class="row clearfix profile">
	                    <div class="col-sm-4" style="margin:14px 0">	                       
								<div class="_photo_cont">
									<div id="upload_cont" class="upo">
										<div class="overlay hide"></div>
										<div class="no-dp hide">
										  <div class="f_int">
											<p class="hou">Change Avatar</p>
											<div class="hou ui-fg" id="dp-cont">
												<c:url value="/upload" var="upload" />
												<c:url value="/file" var="filePath" />
												<form action="#${upload}" enctype="multipart/form-data"	method="post">
													<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
													Select Photo: <input type="file" accept="image/*" name="file" /> 
													<input type="submit" value="upload" />
												</form>
												<img src="${contextPath}/resources/images/banner1.jpg" height="150" width="150" alt="Upload image">
											</div><!--#dp-cont  "${filePath}"-->
										  </div><!--f-int-->
										</div><!--no-dp-->
									</div><!--#upload_cont-->

									<div class="_photo text-center upo">
										<img class="img-circle" alt="avatar" src="${contextPath}/resources/images/banner1.jpg" height="150" width="150">
									</div><!--_photo-->

								</div><!-- _photo_cont -->
								
								<!-- <h3 style="color: #337ab7">Welcome ${user.getFirstname()}</h3>  -->			               
	                    </div>
	                    <div class="col-sm-4" style="margin:24px 0">				            
				                <div class="name_group">
				                  <h1><strong style="color: #23527c;">${user.getFirstname()}</strong>
				                  <small>@${user.getUsername()}</small>
				                  </h1>				                  
				                </div><!--name_group-->				              		
						</div><!--_two-->
	                    <div class="col-sm-4">
	                        <ul class="nav navbar-nav navbar-right menu menu-right">
	                            <li><a href="${contextPath}/users/post" class="btn">Create Rant</a></li>
	                            <li><a href = "${contextPath}/users/profile/edit" class="btn">Edit Profile</a></li>
	                        </ul>
	                    </div>    
	                </div>    
	                
	                <div class="row">
                    <div class="col-md-8 col-md-offset-2 col-sm-12">
                    	<div class="clearfix">
                    		<c:choose>
		                    	<c:when test="${posts != null}">
		                        	<c:forEach  items="${posts}" var ="post">
<!--                     					<div class="col-sm-6 col-md-6">
 -->		                                    <div class="list col-sm-6 col-md-6">
		                                        <div class="list-item" style="">
		                                            <div class="list-content">
		                                                <h3><a href="${contextPath}/users/rant/${post.getId()}">${post.getTitle()}</a></h3>
		                                                <c:set var="shortDesc" value="${fn:substring(post.getRant(), 0, 150)}" />
		                                                <p><i class="fa fa-quote-left"></i> &nbsp;${shortDesc}....</p>
		                                            </div><!-- list-content -->
		                                        </div><!--list-item -->								
		                                    </div><!--list -->
	                                   
		                            </c:forEach> 
		                             <br />
		                        </c:when>        		                                
	                          	<c:otherwise>
	                          		<p>No post found</p>
	                              	<!-- <div class="list">
                                        <div class="list-item" style="">
                                            <div class="list-content">
                                                <p><i class="fa fa-quote-left"></i> &nbsp;No post found</p>
                                            </div>
                                        </div>						
		                            </div> -->
		                            <br />
		                        </c:otherwise>
	                        </c:choose>
	                    </div><!-- clearfix -->		                                
	                </div><!-- inner row -->                	
                </div>  <!-- row -->
              </div>  <!-- row -->
           </c:when>
       	   <c:otherwise>
                	<p style="color: #ccc;font-size: 24px;font-weight: 500">${info}</p>
           </c:otherwise>
        </c:choose> 
      </div><!-- main -->
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
                      <h5 class="modal-title" style="color: #0F6BBA">Delete Account</h5>
                    </div>

                    <!-- Modal body -->
                    <div class="modal-body">
                        <p>Are you sure you want to delete?</p>
                        <li><a onclick="document.forms['deleteUser'].submit()" class="btn btn-secondary pull-left">Delete Account</a></li>
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                        <form id="deleteUser" method="POST" action="${contextPath}/delete">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        </form>
                    </div>
                      
                  </div>
                </div>
              </div><!-- Modal end -->
        <script src="${contextPath}/resources/js/jquery.min.js"></script>
        <script src="${contextPath}/resources/js/bootstrap.min.js"></script>
    </body>
</html>
