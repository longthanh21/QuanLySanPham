package com.example.testlv3.service;

import com.example.testlv3.entity.Product;
import com.example.testlv3.entity.ProductResponse;
import com.example.testlv3.repo.ProductBrandRepository;
import com.example.testlv3.repo.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductService {
    @Autowired
    ProductRepository productRepository;

    @Autowired
    ProductBrandRepository productBrandRepository;

    public Page<ProductResponse> getAll(Pageable pageable){
        return productRepository.getAllProductResponse(pageable);
    }

    public Product findById(Integer id){
        return productBrandRepository.findById(id).get().getProduct();
    }

    public void add(Product product){
        productRepository.save(product);
    }

    public void edit(Product product){
        productRepository.save(product);
    }

    public void delete(Product product){
        productRepository.delete(product);
    }
}
