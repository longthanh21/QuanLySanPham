package com.example.testlv3.repo;

import com.example.testlv3.entity.ProductBrand;
import com.example.testlv3.entity.ProductBrandResponse;
import com.example.testlv3.entity.ProductResponse;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProductBrandRepository extends JpaRepository<ProductBrand, Integer> {
    @Query("""
        SELECT pb FROM ProductBrand pb 
        WHERE (:name IS NULL OR pb.product.name LIKE %:name%)
        AND (:price IS NULL OR pb.product.price = :price)
        AND (:brandId IS NULL OR pb.brand.id = :brandId)
        AND (:subCategoryId IS NULL OR pb.product.subCategory.id = :subCategoryId)
        AND (:statusId IS NULL OR pb.product.status.id = :brandId)
    """)
    List<ProductBrand> searchProducts(
            @Param("name") String name,
            @Param("price") Double price,
            @Param("brandId") Integer brandId,
            @Param("subCategoryId") Integer subCategoryId,
            @Param("statusId") Integer statusId
    );

    Page<ProductBrand> findAll(Pageable pageable);

    @Query("""
       SELECT new  com.example.testlv3.entity.ProductBrandResponse(
       pb.id,
       pb.brand,
       pb.product
       ) FROM ProductBrand pb
    """)
    Page<ProductBrandResponse> getAllProductBrandResponse(Pageable pageable);
}
