<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container mt-3">
    <h2 class="mb-5">Product</h2>
    <form action="/product/search" class="row g-3 mb-3" method="post">
        <div class="row">
            <div class="col-md-2">
                Name: <input type="text" name="name" value="${name}" class="form-control">
            </div>
            <div class="col-md-2">
                Price: <input type="number" name="price" value="${price}" class="form-control">
            </div>
            <div class="col-md-2">
                Brand:
                <select name="brand" class="form-select" >
                    <C:forEach items="${listBrand}" var="b">
                        <option value="${b.id}" label="${b.name}" ${brand == b.id ? 'selected':''}></option>
                    </C:forEach>
                </select>
            </div>
            <div class="col-md-2">
                Category:
                <select name="category" class="form-select">
                    <C:forEach items="${listSubCategory}" var="c">
                        <option value="${c.id}" label="${c.name}" ${category == c.id ? 'selected':''}></option>
                    </C:forEach>
                </select>
            </div>
            <div class="col-md-2">
                Status:
                <select name="status" class="form-select">
                    <C:forEach items="${listStatus}" var="s">
                        <option value="${s.id}" label="${s.name}" ${status == s.id ? 'selected':''}></option>
                    </C:forEach>
                </select>
            </div>
            <div class="col-md-2">
                <br>
                <button class="btn btn-success">
                    <i class="bi bi-search"></i>
                </button>
            </div>
        </div>
    </form>

    <button type="button" class="btn btn-success mb-5" data-bs-toggle="modal" data-bs-target="#exampleModal">
        Add Product
    </button>

    <c:if test="${not empty successMessage}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
                ${successMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <c:if test="${not empty emptyListMessage}">
        <div class="alert alert-warning">
                ${emptyListMessage}
        </div>
    </c:if>

    <table class="table table-striped " border="1">
        <thead>
            <th>No</th>
            <th>Product Name</th>
            <th>Brand Name</th>
            <th>SubCategory</th>
            <th>Price</th>
            <th>Status</th>
            <th>Function</th>
        </thead>
        <tbody>
        <c:forEach items="${listProduct}" var="pb" varStatus="i">
            <tr>
                <td>${i.count}</td>
                <td>${pb.product.name}</td>
                <td>${pb.brand.name}</td>
                <td>${pb.product.subCategory.name}</td>
                <td>${pb.product.price}</td>
                <td>${pb.product.status.name}</td>
                <td>
                    <div>
                        <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#detailModal${pb.id}">
                            <i class="bi bi-eye-fill"></i>
                        </button>
                        <button type="button" class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#editModal${pb.id}">
                            <i class="bi bi-pencil-fill"></i>
                        </button>
                        <button class="btn btn-danger">
                            <a onclick="return confirm('Do you want to delete?')" href="/product/remove/${pb.id}">
                                <i class="bi bi-trash3-fill"></i>
                            </a>
                        </button>
                    </div>
                </td>
            </tr>

            <!-- Modal Detail-->
            <div class="modal fade" id="detailModal${pb.id}" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="detailModal" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5" id="detailModal">Detail Product</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <div class="container">
                                <form action="" method="post">
                                    <div class="row mb-3">
                                        <label class="col-sm-3 col-form-label">Name</label>
                                        <div class="col-sm-9">
                                            <input type="text" name="name" class="form-control" value="${pb.product.name}" readonly/>
                                            <c:if test="${not empty erName}">
                                                <span class="text-danger">${erName}</span>
                                            </c:if>
                                        </div>
                                    </div>

                                    <div class="row mb-3">
                                        <label class="col-sm-3 col-form-label">Color</label>
                                        <div class="col-sm-9">
                                            <input type="text" name="color" class="form-control" value="${pb.product.color}" readonly/>
                                            <c:if test="${not empty erColor}">
                                                <span class="text-danger">${erColor}</span>
                                            </c:if>
                                        </div>
                                    </div>

                                    <div class="row mb-3">
                                        <label class="col-sm-3 col-form-label">Quantity</label>
                                        <div class="col-sm-9">
                                            <input type="number" name="quantity" class="form-control" value="${pb.product.quantity}" readonly/>
                                            <c:if test="${not empty erQuantity}">
                                                <span class="text-danger">${erQuantity}</span>
                                            </c:if>
                                        </div>
                                    </div>

                                    <div class="row mb-3">
                                        <label class="col-sm-3 col-form-label">Sell Price</label>
                                        <div class="col-sm-9">
                                            <input type="number" name="price" class="form-control" value="${pb.product.price}" readonly/>
                                            <c:if test="${not empty erPrice}">
                                                <span class="text-danger">${erPrice}</span>
                                            </c:if>
                                        </div>
                                    </div>

                                    <div class="row mb-3">
                                        <label class="col-sm-3 col-form-label">Origin Price</label>
                                        <div class="col-sm-9">
                                            <input type="number" name="orgPrice" class="form-control" value="${pb.product.orgPrice}" readonly/>
                                            <c:if test="${not empty erOrgPrice}">
                                                <span class="text-danger">${erOrgPrice}</span>
                                            </c:if>
                                        </div>
                                    </div>

                                    <div class="row mb-3">
                                        <label class="col-sm-3 col-form-label">Brand Name</label>
                                        <div class="col-sm-9">
                                            <select name="brand" class="form-select">
                                                <c:forEach var="brand" items="${listBrand}">
                                                    <option value="${brand.id}" ${pb.brand.id==brand.id?'selected':''}>${brand.name}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="row mb-3">
                                        <label class="col-sm-3 col-form-label">Subcategory</label>
                                        <div class="col-sm-9">
                                            <select name="subCategory" class="form-select">
                                                <c:forEach var="subCategory" items="${listSubCategory}">
                                                    <option value="${subCategory.id}" ${pb.product.subCategory.id==subCategory.id?'selected':''}>${subCategory.name}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="row mb-3">
                                        <label class="col-sm-3 col-form-label">Subcategory</label>
                                        <div class="col-sm-9">
                                            <select name="subCategory" class="form-select">
                                                <c:forEach var="status" items="${listStatus}">
                                                    <option value="${status.id}" ${pb.product.status.id==status.id?'selected':''}>${status.name}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="row mb-3">
                                        <div class="col-sm-9 offset-sm-3">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Modal Edit-->
            <div class="modal fade" id="editModal${pb.id}" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="editModal" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5" id="editModal">Edit Product</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <div class="container">
                                <form action="/product/edit/${pb.id}" method="post">
                                    <div class="row mb-3">
                                        <label class="col-sm-3 col-form-label">Name</label>
                                        <div class="col-sm-9">
                                            <input type="text" name="name" class="form-control" value="${pb.product.name}"/>
                                            <c:if test="${not empty erName1}">
                                                <span class="text-danger">${erName1}</span>
                                            </c:if>
                                        </div>
                                    </div>

                                    <div class="row mb-3">
                                        <label class="col-sm-3 col-form-label">Color</label>
                                        <div class="col-sm-9">
                                            <input type="text" name="color" class="form-control" value="${pb.product.color}"/>
                                            <c:if test="${not empty erColor1}">
                                                <span class="text-danger">${erColor1}</span>
                                            </c:if>
                                        </div>
                                    </div>

                                    <div class="row mb-3">
                                        <label class="col-sm-3 col-form-label">Quantity</label>
                                        <div class="col-sm-9">
                                            <input type="number" name="quantity" class="form-control" value="${pb.product.quantity}"/>
                                            <c:if test="${not empty erQuantity1}">
                                                <span class="text-danger">${erQuantity1}</span>
                                            </c:if>
                                        </div>
                                    </div>

                                    <div class="row mb-3">
                                        <label class="col-sm-3 col-form-label">Sell Price</label>
                                        <div class="col-sm-9">
                                            <input type="number" name="price" class="form-control" value="${pb.product.price}"/>
                                            <c:if test="${not empty erPrice1}">
                                                <span class="text-danger">${erPrice1}</span>
                                            </c:if>
                                        </div>
                                    </div>

                                    <div class="row mb-3">
                                        <label class="col-sm-3 col-form-label">Origin Price</label>
                                        <div class="col-sm-9">
                                            <input type="number" name="orgPrice" class="form-control" value="${pb.product.orgPrice}"/>
                                            <c:if test="${not empty erOrgPrice1}">
                                                <span class="text-danger">${erOrgPrice1}</span>
                                            </c:if>
                                        </div>
                                    </div>

                                    <div class="row mb-3">
                                        <label class="col-sm-3 col-form-label">Brand Name</label>
                                        <div class="col-sm-9">
                                            <select name="brand" class="form-select">
                                                <c:forEach var="brand" items="${listBrand}">
                                                    <option value="${brand.id}" ${pb.brand.id==brand.id?'selected':''}>${brand.name}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="row mb-3">
                                        <label class="col-sm-3 col-form-label">Subcategory</label>
                                        <div class="col-sm-9">
                                            <select name="subCategory" class="form-select">
                                                <c:forEach var="subCategory" items="${listSubCategory}">
                                                    <option value="${subCategory.id}" ${pb.product.subCategory.id==subCategory.id?'selected':''}>${subCategory.name}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="row mb-3">
                                        <label class="col-sm-3 col-form-label">Subcategory</label>
                                        <div class="col-sm-9">
                                            <select name="status" class="form-select">
                                                <c:forEach var="status" items="${listStatus}">
                                                    <option value="${status.id}" ${pb.product.status.id==status.id?'selected':''}>${status.name}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="row mb-3">
                                        <div class="col-sm-9 offset-sm-3">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                            <button type="submit" class="btn btn-primary">Save changes</button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
        </tbody>
    </table>
    <!-- Nút chuyển trang -->
    <nav aria-label="Page navigation example">
        <ul class="pagination">
            <c:if test="${currentPage > 0}">
                <li class="page-item">
                    <a class="page-link" href="?page=${currentPage - 1}&size=${size}" aria-label="Previous">
                        <span aria-hidden="true">&laquo;</span>
                    </a>
                </li>
            </c:if>

<%--            <c:forEach var="i" begin="0" end="${totalPages - 1}">--%>
<%--                <li class="page-item ${currentPage == i ? 'active' : ''}">--%>
<%--                    <a class="page-link" href="?page=${i}&size=${size}">${i + 1}</a>--%>
<%--                </li>--%>
<%--            </c:forEach>--%>

            <c:if test="${totalPages > 0}">
                <c:forEach var="i" begin="0" end="${totalPages - 1}">
                    <li class="page-item ${currentPage == i ? 'active' : ''}">
                        <a class="page-link" href="?page=${i}&size=${size}">${i + 1}</a>
                    </li>
                </c:forEach>
            </c:if>
            <c:if test="${totalPages == 0}">
                <li class="page-item">
                    <span class="page-link">Không có trang nào.</span>
                </li>
            </c:if>

            <c:if test="${currentPage < totalPages - 1}">
                <li class="page-item">
                    <a class="page-link" href="?page=${currentPage + 1}&size=${size}" aria-label="Next">
                        <span aria-hidden="true">&raquo;</span>
                    </a>
                </li>
            </c:if>
        </ul>
    </nav>
</div>

<%--Add--%>
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="exampleModalLabel">Add Product</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="container">
                    <form action="/product/add" method="post">
                        <div class="row mb-3">
                            <label class="col-sm-3 col-form-label">Name</label>
                            <div class="col-sm-9">
                                <input type="text" name="name" class="form-control" value="${pb.product.name}"/>
                                <c:if test="${not empty erName}">
                                    <span class="text-danger">${erName}</span>
                                </c:if>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label class="col-sm-3 col-form-label">Color</label>
                            <div class="col-sm-9">
                                <input type="text" name="color" class="form-control" value="${p.product.color}"/>
                                <c:if test="${not empty erColor}">
                                    <span class="text-danger">${erColor}</span>
                                </c:if>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label class="col-sm-3 col-form-label">Quantity</label>
                            <div class="col-sm-9">
                                <input type="number" name="quantity" class="form-control" value="${p.product.quantity}"/>
                                <c:if test="${not empty erQuantity}">
                                    <span class="text-danger">${erQuantity}</span>
                                </c:if>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label class="col-sm-3 col-form-label">Sell Price</label>
                            <div class="col-sm-9">
                                <input type="number" name="price" class="form-control" value="${p.product.price}"/>
                                <c:if test="${not empty erPrice}">
                                    <span class="text-danger">${erPrice}</span>
                                </c:if>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label class="col-sm-3 col-form-label">Origin Price</label>
                            <div class="col-sm-9">
                                <input type="number" name="orgPrice" class="form-control" value="${p.product.orgPrice}"/>
                                <c:if test="${not empty erOrgPrice}">
                                    <span class="text-danger">${erOrgPrice}</span>
                                </c:if>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label class="col-sm-3 col-form-label">Brand Name</label>
                            <div class="col-sm-9">
                                <select name="brand" class="form-select">
                                    <c:forEach var="brand" items="${listBrand}">
                                        <option value="${brand.id}">${brand.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label class="col-sm-3 col-form-label">Subcategory</label>
                            <div class="col-sm-9">
                                <select name="subCategory" class="form-select">
                                    <c:forEach var="subCategory" items="${listSubCategory}">
                                        <option value="${subCategory.id}">${subCategory.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-sm-9 offset-sm-3">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                <button type="submit" class="btn btn-primary">Save changes</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

