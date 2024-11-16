package com.example.testlv3.repo;

import com.example.testlv3.entity.Product;
import com.example.testlv3.entity.ProductResponse;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProductRepository extends JpaRepository<Product, Integer> {
    @Query("""
        SELECT new com.example.testlv3.entity.ProductResponse(
            p.id,
            p.name,
            p.color,
            p.quantity,
            p.price,
            p.orgPrice,
            p.desc,
            p.subCategory,
            p.status
        ) FROM Product p
    """)
    Page<ProductResponse> getAllProductResponse(Pageable pageable);
}
