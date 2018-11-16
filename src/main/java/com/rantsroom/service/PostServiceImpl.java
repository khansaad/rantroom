package com.rantsroom.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.rantsroom.model.Post;
import com.rantsroom.model.User;
import com.rantsroom.repository.PostRepository;
import com.rantsroom.repository.PostRepositoryImpl;

@Service
public class PostServiceImpl extends PostRepositoryImpl implements PostService {

	@Autowired
	private PostRepository postRepository;
	
	
	@Override
	public void save(Post post) {
		
		postRepository.save(post);
	}

	@Override
	public Post findByTitle(String title) {
		
		return postRepository.findByTitle(title);
	}

	

	@Override
	public List<Post> findAll() {
		// TODO Auto-generated method stub
		return postRepository.findAll();
	}

	@Override
	public List<Post> findAllById(Long Id) {
		// TODO Auto-generated method stub
		return super.findAllById(Id);
	}

	@Override
	public Optional<Post> findById(Long Id) {
		// TODO Auto-generated method stub
		return postRepository.findById(Id);
	}

	@Override
	public List<Post> findByUser(User user) {
		// TODO Auto-generated method stub
		return postRepository.findByUser(user);
	}
	
}
