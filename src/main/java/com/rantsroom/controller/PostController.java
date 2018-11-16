package com.rantsroom.controller;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.rantsroom.exception.ResourceNotFoundException;
import com.rantsroom.model.Post;
import com.rantsroom.model.User;
import com.rantsroom.repository.PostRepository;
import com.rantsroom.service.PostService;
import com.rantsroom.service.PostServiceImpl;
import com.rantsroom.service.SecurityService;
import com.rantsroom.service.UserService;
import com.rantsroom.validator.PostValidator;

import java.security.Principal;
import java.util.List;
import java.util.Optional;

import javax.validation.Valid;

@Controller
public class PostController {

	private Logger logger = LoggerFactory.getLogger(this.getClass());
    @Autowired
    private PostService postService;
    
    @Autowired
    private UserService userService;
    
    @Autowired
    private PostValidator postValidator;
    
    @Autowired
    private PostRepository postRepository;
    
    @Autowired
    private PostServiceImpl postServiceImpl;
    
    @RequestMapping(value = "/users/post", method = RequestMethod.GET)
    public String createPost(Model model, Principal principal) {
    	    
    	User user = null;
		try {
			user = userService.findByUsername(principal.getName());
		} catch (NullPointerException e) {
			logger.error("No user logged in");
		}
    	model.addAttribute("user", user);
    	model.addAttribute("postForm", new Post());    	
        return "users/post";        		
    }
    
    @RequestMapping(value = "/users/post", method = RequestMethod.POST)
    public String createPost(@ModelAttribute("postForm") Post postform,BindingResult bindingResult, Model model,Principal principal) {

    	
    	User user = userService.findByUsername(principal.getName());
    	model.addAttribute("user", user);
    	postValidator.validate(postform, bindingResult);
    	
    	if (bindingResult.hasErrors())
            return "users/post";
        
    	else {
        	postform.setUser(userService.findByUsername(principal.getName()));
	    	postService.save(postform);
	    	
	        return "redirect:/users/postsuccess";
    	}
        		
    }
    @RequestMapping(value = "/users/postsuccess", method = RequestMethod.GET)
    public String success(Model model,Principal principal) {    	
    	
    	User user = userService.findByUsername(principal.getName());
    	model.addAttribute("user", user);
    	model.addAttribute("verifyPost", "Success!  Your Rant is posted.");
        return "/users/postsuccess";
    }
    
    @RequestMapping(value = "/rant/{postId}", method = RequestMethod.GET)
    public String PostDetails(@PathVariable Long postId,Model model, Principal principal) {
    	
    	User user = null;
		try {
			user = userService.findByUsername(principal.getName());
		} catch (NullPointerException e) {
			logger.error("No user logged in");
		}
    	model.addAttribute("user", user);
    	Optional<Post> post = postService.findById(postId);
		model.addAttribute("postDesc", post.get());
		return "/users/post";
    }
    @RequestMapping(value = "/editrant/{postId}", method = RequestMethod.GET)
    public String editPost(@PathVariable Long postId,Model model, Principal principal) {
    	
    	User user = userService.findByUsername(principal.getName());
    	model.addAttribute("user", user);
    	Optional<Post> post = postService.findById(postId);
		model.addAttribute("postForm", post.get());
		return "/users/editPost";
    }
    
    @RequestMapping(value = "/editrant/{postId}", method = RequestMethod.POST)
    public String editPost(@PathVariable Long postId, @ModelAttribute("postForm") Post postform,
    		Model model, Principal principal, BindingResult bindingResult) {
    	
    	postValidator.validate(postform, bindingResult);
    	
    	if (bindingResult.hasErrors())
            return "/editrant/"+postId;
        
    	else {
    		Optional<Post> post = postService.findById(postId);
    		updatePost(post, postform);
	    	postService.save(post.get());
	    	String rantUpdated = "Rant is updated succesfully";
			model.addAttribute("rantUpdated",rantUpdated);
			model.addAttribute("post",post);
	        return "redirect:/rant/"+postId;
    	}
    }
	
	 @RequestMapping(value = "/deleterant/{postId}", method = RequestMethod.POST)
	    public String deletePost(@PathVariable Long postId,Model model,
	    		RedirectAttributes redirectAttributes,Principal principal) {
	    	
		postRepository.deleteById(postId);
		User user = userService.findByUsername(principal.getName());
		redirectAttributes.addFlashAttribute("deleterant", "Your rant has been deleted successfully.");
		model.addAttribute("user", user);
		List<Post> post = postServiceImpl.findAllById(user.getId());
		model.addAttribute("posts", post);
		return "redirect:/users/profile";
	 }
	 private void updatePost(Optional<Post> post, Post postform) {
		 post.get().setTitle(postform.getTitle());
		 post.get().setRant(postform.getRant());
		 
	 }
}



    /*
public static Long getCurrentUserId() {
	SecurityContext securityContext = SecurityContextHolder.getContext();
	Authentication authentication = securityContext.getAuthentication();
	String id = null;
	if (authentication != null)
		if (authentication.getPrincipal() instanceof UserDetails)
			id = ((UserDetails) authentication.getPrincipal()).getUsername();
		else if (authentication.getPrincipal() instanceof String)
			id = (String) authentication.getPrincipal();
	try {
		return Long.valueOf(id != null ? id : "1"); //anonymoususer
	} catch (NumberFormatException e) {
		return 1L;
	}
}


    @RequestMapping(value = "/posts/{postId}", method = RequestMethod.DELETE)
    public ResponseEntity<?> deletePost(@PathVariable Long postId) {
        return postRepository.findById(postId).map(post -> {
            postRepository.delete(post);
            return ResponseEntity.ok().build();
        }).orElseThrow(() -> new ResourceNotFoundException("PostId " + postId + " not found"));
    }
    @RequestMapping(value = "/posts", method = RequestMethod.GET)
    public Page<Post> getAllPosts(Pageable pageable) {
        return postRepository.findAll(pageable);
    }*/


