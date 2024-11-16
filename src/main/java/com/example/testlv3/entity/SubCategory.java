package com.example.testlv3.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "sub_category")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class SubCategory {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Integer id;

    @Column(name = "sub_cate_code")
    String code;

    @Column(name = "sub_cate_name")
    String name;

    @ManyToOne @JoinColumn(name = "cate_id")
    Category category;
}
