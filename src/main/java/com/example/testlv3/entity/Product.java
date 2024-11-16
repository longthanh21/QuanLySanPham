package com.example.testlv3.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.*;

import java.util.List;

@Entity
@Table(name = "product")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Product {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Integer id;

    @Column(name = "product_name")
    String name;

    @Column(name = "color")
    String color;

    @Column(name = "quantity")
    Integer quantity;

    @Column(name = "sell_price")
    Double price;

    @Column(name = "origin_price")
    Double orgPrice;

    @Column(name = "description")
    String desc;

    @ManyToOne @JoinColumn(name = "subcate_id")
    SubCategory subCategory;

    @ManyToOne @JoinColumn(name = "status_id")
    Status status;
}
