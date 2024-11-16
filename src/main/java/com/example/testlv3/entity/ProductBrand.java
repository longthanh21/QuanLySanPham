package com.example.testlv3.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "product_brand")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ProductBrand {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Integer id;

    @ManyToOne
    @JoinColumn(name = "brand_id")
    private Brand brand;

    @ManyToOne
    @JoinColumn(name = "product_id")
    private Product product;
}
