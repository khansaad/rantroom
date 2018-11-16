package com.rantsroom.service;

import java.util.List;
import java.util.Optional;

import com.rantsroom.model.Post;
import com.rantsroom.model.User;

public interface PostService {
	
	void save (Post post);
	Post findByTitle(String title);
	List<Post> findByUser(User user);
	List<Post> findAll();
	Optional<Post> findById(Long Id);
}
