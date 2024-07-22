package com.shopping.shop.service;

import com.shopping.shop.entity.Product;
import com.shopping.shop.repository.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ProductService {

    @Autowired
    private ProductRepository productRepository;

    public void saveProduct(Product product) {
        productRepository.save(product);
    }

    public Product updateProduct(Product product) {
        Optional<Product> dbproduct = productRepository.findById(product.getId());
        Product exProduct = dbproduct.get();
        exProduct.setName(product.getName());
        exProduct.setCode(product.getCode());
        exProduct.setPrice(product.getPrice());
        exProduct.setDescription(product.getDescription());
        exProduct.setImageURL(product.getImageURL());
        return productRepository.save(exProduct);
    }

    public void deleteProduct(int id) {
        Optional<Product> dbproduct = productRepository.findById(id);
        productRepository.delete(dbproduct.get());
    }

    public Product findById(int id) {
        Optional<Product> dbproduct = productRepository.findById(id);
        return dbproduct.orElseGet(Product::new);
    }

    public List<Product> findALl() {
        return productRepository.findAll();

    }


}
