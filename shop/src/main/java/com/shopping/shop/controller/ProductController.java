package com.shopping.shop.controller;

import com.shopping.shop.entity.Product;
import com.shopping.shop.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/product")
@CrossOrigin(origins = "*")
public class ProductController {

    @Autowired
    private ProductService productService;

    @PostMapping("/register")
    public ResponseEntity<Void> save(@RequestBody Product product){
        productService.saveProduct(product);
        return ResponseEntity.ok().build();
    }

    @DeleteMapping("/deleteById")
    public ResponseEntity<Void> delete(@RequestParam int id){
        Optional<Product> productOptional = Optional.ofNullable(productService.findById(id));
        if (productOptional.isPresent()) {
            productService.deleteProduct(id);
            return ResponseEntity.ok().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @GetMapping("/findById")
    public ResponseEntity<Product> findUserById(@RequestParam int id){
        Optional<Product> productOptional = Optional.ofNullable(productService.findById(id));
        return productOptional.map(ResponseEntity::ok).orElseGet(() -> ResponseEntity.notFound().build());
    }

    @GetMapping("/findAll")
    public ResponseEntity<List<Product>> findAll(){
        List<Product> products = productService.findALl();
        return ResponseEntity.ok().body(products);
    }

    @PutMapping("/update")
    public ResponseEntity<Product> updateUser(@RequestBody Product product){
        Optional<Product> productOptional = Optional.ofNullable(productService.findById(product.getId()));
        if (productOptional.isPresent()) {
            Product updatedProduct = productService.updateProduct(product);
            return ResponseEntity.ok().body(updatedProduct);
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}
