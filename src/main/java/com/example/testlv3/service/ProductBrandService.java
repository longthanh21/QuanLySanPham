package com.example.testlv3.service;

import com.example.testlv3.entity.Product;
import com.example.testlv3.entity.ProductBrand;
import com.example.testlv3.entity.ProductBrandResponse;
import com.example.testlv3.repo.ProductBrandRepository;
import com.example.testlv3.repo.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

@Service
public class ProductBrandService {
    @Autowired
    ProductRepository productRepository;

    @Autowired
    ProductBrandRepository productBrandRepository;

    public Page<ProductBrandResponse> getAll(Pageable pageable){
        return productBrandRepository.getAllProductBrandResponse(pageable);
    }

    public ProductBrand findById(Integer id){
        return productBrandRepository.findById(id).get();
    }

    public void add(ProductBrand product){
        productBrandRepository.save(product);
    }

    public void edit(ProductBrand product){
        productBrandRepository.save(product);
    }

    public void delete(Integer id){
        productBrandRepository.deleteById(id);
    }
}
