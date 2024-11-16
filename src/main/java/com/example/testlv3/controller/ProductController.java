package com.example.testlv3.controller;

import com.example.testlv3.entity.*;
import com.example.testlv3.repo.*;
import com.example.testlv3.service.ProductBrandService;
import com.example.testlv3.service.ProductService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("product")
public class ProductController {

//    @Autowired
//    ProductRepository productRepositoy;
    @Autowired
    ProductService productService;

    @Autowired
    ProductBrandService productBrandService;

    @Autowired
    BrandRepository brandRepositoy;

    @Autowired
    StatusRepository statusRepositoy;

    @Autowired
    SubCategoryRepository subCategoryRepositoy;

    @Autowired
    ProductBrandRepository productBrandRepository;

//    @GetMapping("index")
//    public String view(Model model){
//        model.addAttribute("listBrand", brandRepositoy.findAll());
//        model.addAttribute("listSubCategory", subCategoryRepositoy.findAll());
//        model.addAttribute("listStatus", statusRepositoy.findAll());
//        model.addAttribute("listProduct", productBrandRepository.findAll());
//        return "index";
//    }

    @GetMapping("index")
    public String view(
            Model model,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "3") int size
    ) {
        if (page < 0) {
            page = 0;
        }

        Pageable pageable = PageRequest.of(page, size);
        Page<ProductBrandResponse> productPage = productBrandService.getAll(pageable);

        model.addAttribute("listBrand", brandRepositoy.findAll());
        model.addAttribute("listSubCategory", subCategoryRepositoy.findAll());
        model.addAttribute("listStatus", statusRepositoy.findAll());
        model.addAttribute("listProduct", productPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", productPage.getTotalPages());

        return "index";
    }

    @PostMapping("search")
    public String search(
            @RequestParam(required = false) String name,
            @RequestParam(required = false) Double price,
            @RequestParam(required = false) Integer brand,
            @RequestParam(required = false) Integer category,
            @RequestParam(required = false) Integer status,
            Model model
    ) {
        List<ProductBrand> listProductBrand = productBrandRepository.searchProducts(name, price, brand, category, status);

        if (listProductBrand.isEmpty()) {
            model.addAttribute("emptyListMessage", "List is empty");
        }
        model.addAttribute("name", name);
        model.addAttribute("price", price);
        model.addAttribute("brand", brand);
        model.addAttribute("category", category);
        model.addAttribute("status", status);
        model.addAttribute("listProduct", listProductBrand);
        model.addAttribute("listBrand", brandRepositoy.findAll());
        model.addAttribute("listSubCategory", subCategoryRepositoy.findAll());
        model.addAttribute("listStatus", statusRepositoy.findAll());
        return "index";
    }


    @PostMapping("add")
    public String add(RedirectAttributes redirectAttributes,
                      Model model, Product product,
                      ProductRequest productRequest,
                      @RequestParam("brand") Brand brand,
                      @RequestParam(defaultValue = "0") int page,
                      @RequestParam(defaultValue = "3") int size) {
        boolean hasErrors = false;

        if (product.getName() == null || product.getName().isEmpty()) {
            model.addAttribute("erName", "Name is required");
            hasErrors = true;
        }

        if (product.getColor() == null || product.getColor().isEmpty()) {
            model.addAttribute("erColor", "Color is required");
            hasErrors = true;
        }

        if (product.getQuantity() == null || product.getQuantity() <= 0) {
            model.addAttribute("erQuantity", "Quantity must be greater than 0");
            hasErrors = true;
        }

        if (product.getPrice() == null || product.getPrice() <= 0) {
            model.addAttribute("erPrice", "Sell Price must be greater than 0");
            hasErrors = true;
        }

        if (product.getOrgPrice() == null || product.getOrgPrice() <= 0) {
            model.addAttribute("erOrgPrice", "Origin Price must be greater than 0");
            hasErrors = true;
        }

        if (hasErrors) {
            model.addAttribute("product", product);
            model.addAttribute("listBrand", brandRepositoy.findAll());
            model.addAttribute("listSubCategory", subCategoryRepositoy.findAll());
            model.addAttribute("listStatus", statusRepositoy.findAll());
//            model.addAttribute("listProduct", productBrandRepository.findAll());

            model.addAttribute("currentPage", page);
            model.addAttribute("size", size);

            Pageable pageable = PageRequest.of(page, size);
            Page<ProductBrand> productPage = productBrandRepository.findAll(pageable);
            model.addAttribute("listProduct", productPage.getContent());
            model.addAttribute("totalPages", productPage.getTotalPages());
            return "index";
        }
        BeanUtils.copyProperties(productRequest, product);
        productService.add(product);
        productBrandService.add(new ProductBrand(null, brand, product));
        redirectAttributes.addFlashAttribute("successMessage", "Product added successfully!");
        return "redirect:/product/index";
    }

    @PostMapping("edit/{id}")
    public String edit(@RequestParam(defaultValue = "0") int page,
                       @RequestParam(defaultValue = "3") int size,
                       RedirectAttributes redirectAttributes,
                       Model model, Product product,
                       @PathVariable("id") Integer id,
                       @RequestParam("brand") Brand brand) {
        boolean hasErrors = false;

        if (product.getName() == null || product.getName().isEmpty()) {
            model.addAttribute("erName1", "Name is required");
            hasErrors = true;
        }

        if (product.getColor() == null || product.getColor().isEmpty()) {
            model.addAttribute("erColor1", "Color is required");
            hasErrors = true;
        }

        if (product.getQuantity() == null || product.getQuantity() <= 0) {
            model.addAttribute("erQuantity1", "Quantity must be greater than 0");
            hasErrors = true;
        }

        if (product.getPrice() == null || product.getPrice() <= 0) {
            model.addAttribute("erPrice1", "Sell Price must be greater than 0");
            hasErrors = true;
        }

        if (product.getOrgPrice() == null || product.getOrgPrice() <= 0) {
            model.addAttribute("erOrgPrice1", "Origin Price must be greater than 0");
            hasErrors = true;
        }

        if (hasErrors) {
            model.addAttribute("product", product);
            model.addAttribute("listBrand", brandRepositoy.findAll());
            model.addAttribute("listSubCategory", subCategoryRepositoy.findAll());
            model.addAttribute("listStatus", statusRepositoy.findAll());
//            model.addAttribute("listProduct", productBrandRepository.findAll());
            model.addAttribute("currentPage", page);
            model.addAttribute("size", size);

            Pageable pageable = PageRequest.of(page, size);
            Page<ProductBrand> productPage = productBrandRepository.findAll(pageable);
            model.addAttribute("listProduct", productPage.getContent());
            model.addAttribute("totalPages", productPage.getTotalPages());
            return "index";
        }
        product.setId(productBrandService.findById(id).getProduct().getId());
        productService.edit(product);
        productBrandRepository.save(new ProductBrand(id, brand, product));
        redirectAttributes.addFlashAttribute("successMessage", "Product udpated successfully!");
        return "redirect:/product/index";
    }

    @GetMapping("remove/{id}")
    public String remove(RedirectAttributes redirectAttributes, @PathVariable("id") Integer id) {
        Product product = productBrandRepository.findById(id).get().getProduct();
        productBrandService.delete(id);
        productService.delete(product);
        redirectAttributes.addFlashAttribute("successMessage", "Product removed successfully!");
        return "redirect:/product/index";
    }


}
