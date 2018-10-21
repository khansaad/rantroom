package com.webapp.rantsroom.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.security.access.method.P;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.webapp.rantsroom.model.Post;
import com.webapp.rantsroom.model.User;
import com.webapp.rantsroom.repository.UserRepository;
import com.webapp.rantsroom.service.EmailService;
import com.webapp.rantsroom.service.PostService;
import com.webapp.rantsroom.service.PostServiceImpl;
import com.webapp.rantsroom.service.SecurityService;
import com.webapp.rantsroom.service.UserService;
import com.webapp.rantsroom.validator.UserValidator;

@Controller
//@RequestMapping("/users")
public class UserController {
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
    @Autowired
    private UserService userService;
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private EmailService emailService;    
    @Autowired
    private UserValidator userValidator;
    @Autowired
    private SecurityService securityService;
    @Autowired
    private PostService postService;
    @Autowired
    private PostServiceImpl postServiceImpl;
    

    @RequestMapping(value = "/registration", method = RequestMethod.GET)
    public String registration(Model model) {
        model.addAttribute("userForm", new User());
        return "registration";
    }

    @RequestMapping(value = "/registration", method = RequestMethod.POST)
    public String registration(@ModelAttribute("userForm") User userForm, BindingResult bindingResult, Model model, HttpServletRequest request) {
    	
    	userValidator.validate(userForm, bindingResult);

        if (bindingResult.hasErrors()) {
            return "registration";
        }
        else {
        	// Disable user until they click on confirmation link in email
		    userForm.setActive(false);
		    userForm.setEmail_confirmed(false);
		    
		    // Generate random 36-character string token for confirmation link
		    //userForm.setConfirmationToken(UUID.randomUUID().toString());
		    
		    userService.save(userForm);
		    
		    //Sending verification token via mail
		    sendConfirmationMail(request,userForm);
		    
		    return "redirect:/confirm";
        }
    }
    
    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String login(String error, Model model, String logout, String delete, @AuthenticationPrincipal UserDetails currentUser) {
    	
    	//model.addAttribute("userLogin", new User());
    	if (error != null)
            model.addAttribute("error", "Your username/password is invalid.");

        if (logout != null)
            model.addAttribute("message", "You have been logged out successfully.");
        if(delete != null) {
        	User user = userService.findByUsername(currentUser.getUsername());
        	userRepository.delete(user);
        	model.addAttribute("message", "Your account has been deleted successfully.");
        }
        
        return "login";

//        if(!(userLogin.isEmail_confirmed())) {
//        	model.addAttribute("error", "Oops! Looks like you haven't verified your email yet.Please check your mail box.");
    }
    

    @RequestMapping(value = "/users/welcome", method = RequestMethod.GET)
    public String welcome(Model model, @AuthenticationPrincipal UserDetails currentUser) {
    	
    	User user = userService.findByUsername(currentUser.getUsername());
    	List<Post> posts = postServiceImpl.findAllById(user.getId());
    	model.addAttribute("posts", posts);
        
        return "users/welcome";
    }
    
    @RequestMapping(value = {"/","/home"}, method = RequestMethod.GET)
    public String home(Model model) {    	
    	
    	List<Post> posts = postService.findAll();
    	for(int i = 0; i < posts.size(); i++)
    		logger.info("\nPost Data: \n",posts.get(i).toString());
    	
    	model.addAttribute("posts", posts);
    	model.addAttribute("user", posts);
        return "home";
    }
    
    @RequestMapping(value = "/confirm", method = RequestMethod.GET)
    public String confirm(Model model) {   	
    	
        return "confirm";
    }
    
    @RequestMapping(value = "/verify", method = RequestMethod.GET)
    public String verify(Model model, @RequestParam("token") String token) {   	
    	User user = userService.findByConfirmationToken(token);
    	
    	if (user == null) { // No token found in DB
    		model.addAttribute("verifyUser", "Oops!  This is an invalid confirmation link.");
    	} else { // Token found
    		model.addAttribute("verifyUser", "Success!  Your e-mail is now verified.");
    		user.setActive(true);
    		user.setEmail_confirmed(true);
    	}
        return "verify";
    }
    
    // Sending email for verification
    private void sendConfirmationMail(HttpServletRequest request, User userForm) {
		
    	String appUrl = request.getScheme() + "://" + request.getServerName()+":"+request.getServerPort();
		
		SimpleMailMessage registrationEmail = new SimpleMailMessage();
		registrationEmail.setTo(userForm.getEmail());
		registrationEmail.setSubject("RantsRoom Registration Confirmation");
		registrationEmail.setText("Hi "+userForm.getFirstname()+",\n\nWelcome to RantsRoom! Your portal to rant about anything you like.\n\n"
				+ "To confirm your e-mail address, please click the link below:\n"
				+ appUrl + "/verify?token=" + userForm.getConfirmationToken());
		registrationEmail.setFrom("khan.ssaad@gmail.com");
		
		emailService.sendEmail(registrationEmail);
		
	}

}




/*@RequestMapping(value = "/login", method = RequestMethod.POST)
    public String login(@ModelAttribute("userLogin") User userLogin, String error, Model model) {
		
    	//System.out.println("LOGIN: POST");
		System.out.println("USER Object inside login:"+userLogin.toString());
		boolean loginFlag = true;
        if (error != null) {
            model.addAttribute("error", "Your username and password is invalid.");
            loginFlag = false;
        }
        
        else if(!(userLogin.isEmail_confirmed())) {
        	model.addAttribute("error", "Oops! Looks like you haven't verified your email yet.Please check your mail box.");
        	loginFlag = false;
        }        
        	
        if(loginFlag) {
        	model.addAttribute("firstname", userLogin.getFirstname());
        	//securityService.autologin(userLogin.getUsername(), userLogin.getPassword());
            return "redirect:/welcome";
        }        	
        else
        	return "login";
    }*/