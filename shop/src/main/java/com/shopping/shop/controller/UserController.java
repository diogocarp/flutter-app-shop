package com.shopping.shop.controller;

import com.shopping.shop.entity.User;
import com.shopping.shop.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/user")
@CrossOrigin(origins = "*")
public class UserController {

    @Autowired
    private UserService userService;



    @PostMapping("/register")
    public ResponseEntity<Void> save(@RequestBody User user){
        userService.saveUser(user);
        return ResponseEntity.ok().build();
    }

    @DeleteMapping("/deleteById")
    public ResponseEntity<Void> delete(@RequestParam int id){
        Optional<User> userOptional = Optional.ofNullable(userService.findById(id));
        if (userOptional.isPresent()) {
            userService.deleteUser(id);
            return ResponseEntity.ok().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @GetMapping("/findById")
    public ResponseEntity<User> findUserById(@RequestParam int id){
        Optional<User> userOptional = Optional.ofNullable(userService.findById(id));
        return userOptional.map(ResponseEntity::ok).orElseGet(() -> ResponseEntity.notFound().build());
    }

    @GetMapping("/findAll")
    public ResponseEntity<List<User>> findAll(){
        List<User> users = userService.findALl();
        return ResponseEntity.ok().body(users);
    }

    @PutMapping("/update")
    public ResponseEntity<User> updateUser(@RequestBody User user){
        Optional<User> userOptional = Optional.ofNullable(userService.findById(user.getId()));
        if (userOptional.isPresent()) {
            User updatedUser = userService.updateUser(user);
            return ResponseEntity.ok().body(updatedUser);
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}
