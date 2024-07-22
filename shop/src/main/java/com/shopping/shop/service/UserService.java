package com.shopping.shop.service;

import com.shopping.shop.entity.User;
import com.shopping.shop.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    public void saveUser(User user) {
        userRepository.save(user);
    }

    public User updateUser(User user) {
        Optional<User> dbuser = userRepository.findById(user.getId());
        User exUser = dbuser.get();
        exUser.setUsername(user.getUsername());
        exUser.setPassword(user.getPassword());
        exUser.setEmail(user.getEmail());
        return userRepository.save(exUser);
    }

    public void deleteUser(int id) {
        Optional<User> dbuser = userRepository.findById(id);
        userRepository.delete(dbuser.get());
    }

    public User findById(int id) {
        Optional<User> user = userRepository.findById(id);
        return user.orElseGet(User::new);
    }

    public List<User> findALl() {
        return userRepository.findAll();

    }


}
