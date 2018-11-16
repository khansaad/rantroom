package com.rantsroom.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.rantsroom.model.Post;
import com.rantsroom.model.User;

@Repository
public interface PostRepository extends JpaRepository<Post, Long> {
	
	Post findByTitle(String title);
	List<Post> findByUser(User user);
	List<Post> findAll();
	Optional<Post> findById(Long Id);
}
