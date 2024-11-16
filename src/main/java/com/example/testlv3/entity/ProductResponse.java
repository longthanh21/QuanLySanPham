package com.example.testlv3.entity;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ProductResponse {
    Integer id;

    String name;

    String color;

    Integer quantity;

    Double price;

    Double orgPrice;

    String desc;

    SubCategory subCategory;

    Status status;
}
