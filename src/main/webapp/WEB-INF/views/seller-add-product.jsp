
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Add Product | THOUHA MART</title>

    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: Arial, Helvetica, sans-serif;
        }

        body {
            background: #f7f7fb;
            color: #222;
        }

        .layout {
            display: flex;
            min-height: 100vh;
        }

        /* SIDEBAR */
        .sidebar {
            width: 250px;
            background: #fff;
            border-right: 1px solid #eee;
            padding: 28px 18px;
            position: fixed;
            top: 0;
            bottom: 0;
            left: 0;
            overflow-y: auto;
        }

        .brand {
            font-size: 25px;
            font-weight: 800;
            color: #6c3df4;
            margin-bottom: 8px;
            padding-left: 12px;
        }

        .seller-label {
            color: #888;
            font-size: 13px;
            padding-left: 12px;
            margin-bottom: 30px;
        }

        .menu {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .menu a {
            text-decoration: none;
            color: #555;
            padding: 14px;
            border-radius: 10px;
            font-size: 15px;
            font-weight: 600;
            transition: 0.2s;
        }

        .menu a:hover {
            background: #f1edff;
            color: #6c3df4;
        }

        .menu a.active {
            background: #eee8ff;
            color: #6c3df4;
        }

        .logout {
            margin-top: 20px;
            color: #dc2626 !important;
        }

        .logout:hover {
            background: #fef2f2 !important;
        }

        /* MAIN CONTENT */
        .main {
            margin-left: 250px;
            width: calc(100% - 250px);
            padding: 30px 40px;
        }

        /* TOP BAR */
        .topbar {
            background: #fff;
            border-radius: 16px;
            padding: 22px 25px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 15px;
            margin-bottom: 30px;
            box-shadow: 0 3px 15px rgba(0, 0, 0, 0.04);
        }

        .topbar h1 {
            font-size: 25px;
        }

        .topbar p {
            color: #888;
            margin-top: 7px;
            font-size: 14px;
        }

        .seller-badge {
            background: #f1edff;
            color: #6c3df4;
            padding: 10px 16px;
            border-radius: 30px;
            font-size: 14px;
            font-weight: bold;
            white-space: nowrap;
        }

        /* FORM CARD */
        .form-card {
            background: #fff;
            border-radius: 18px;
            padding: 32px;
            max-width: 1000px;
            box-shadow: 0 4px 18px rgba(0, 0, 0, 0.05);
        }

        .form-card h2 {
            font-size: 21px;
            margin-bottom: 7px;
        }

        .form-description {
            color: #888;
            font-size: 14px;
            margin-bottom: 28px;
            line-height: 1.6;
        }

        /* ERROR AND SUCCESS */
        .error-box {
            background: #fff0f0;
            border: 1px solid #ffcaca;
            color: #c62828;
            padding: 14px 16px;
            border-radius: 10px;
            margin-bottom: 20px;
            font-size: 14px;
        }

        .success-box {
            background: #ecfdf3;
            border: 1px solid #a7f3c0;
            color: #166534;
            padding: 14px 16px;
            border-radius: 10px;
            margin-bottom: 20px;
            font-size: 14px;
        }

        /* FORM */
        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 22px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            min-width: 0;
        }

        .form-group.full {
            grid-column: 1 / -1;
        }

        label {
            font-size: 14px;
            font-weight: 700;
            margin-bottom: 8px;
            color: #333;
        }

        input,
        textarea,
        select {
            width: 100%;
            border: 1px solid #ddd;
            border-radius: 10px;
            padding: 13px 14px;
            font-size: 14px;
            outline: none;
            background: #fff;
            transition: 0.2s;
        }

        input:focus,
        textarea:focus,
        select:focus {
            border-color: #6c3df4;
            box-shadow: 0 0 0 3px rgba(108, 61, 244, 0.10);
        }

        textarea {
            min-height: 130px;
            resize: vertical;
        }

        .hint {
            color: #888;
            font-size: 12px;
            margin-top: 7px;
            line-height: 1.6;
        }

        /* IMAGE UPLOAD */
        .upload-area {
            border: 2px dashed #cfc3ff;
            border-radius: 14px;
            background: #faf9ff;
            padding: 25px;
            text-align: center;
            transition: 0.2s;
        }

        .upload-area:hover {
            border-color: #6c3df4;
            background: #f5f1ff;
        }

        .upload-icon {
            font-size: 38px;
            margin-bottom: 10px;
        }

        .upload-title {
            font-size: 15px;
            font-weight: 700;
            margin-bottom: 7px;
        }

        .upload-description {
            font-size: 12px;
            color: #888;
            margin-bottom: 15px;
        }

        .file-input {
            display: none;
        }

        .choose-file-btn {
            display: inline-block;
            background: #6c3df4;
            color: #fff;
            padding: 12px 20px;
            border-radius: 9px;
            cursor: pointer;
            font-size: 13px;
            font-weight: 700;
            transition: 0.2s;
        }

        .choose-file-btn:hover {
            background: #5930d5;
        }

        .file-name {
            margin-top: 12px;
            font-size: 13px;
            color: #51418a;
            overflow-wrap: anywhere;
        }

        .preview-container {
            display: none;
            margin-top: 20px;
            text-align: center;
        }

        .image-preview {
            max-width: 100%;
            width: 220px;
            height: 220px;
            object-fit: contain;
            background: #fff;
            border: 1px solid #eee;
            border-radius: 12px;
            padding: 8px;
        }

        .remove-image {
            display: block;
            margin: 10px auto 0;
            border: none;
            background: transparent;
            color: #dc2626;
            cursor: pointer;
            font-size: 13px;
            font-weight: 700;
        }

        /* BUTTONS */
        .actions {
            margin-top: 30px;
            display: flex;
            flex-wrap: wrap;
            gap: 12px;
        }

        .btn {
            display: inline-block;
            border: none;
            border-radius: 10px;
            padding: 14px 22px;
            font-size: 14px;
            font-weight: 700;
            cursor: pointer;
            text-decoration: none;
            text-align: center;
            transition: 0.2s;
        }

        .btn-primary {
            background: #6c3df4;
            color: #fff;
        }

        .btn-primary:hover {
            background: #5930d5;
        }

        .btn-secondary {
            background: #f2f2f5;
            color: #555;
        }

        .btn-secondary:hover {
            background: #e8e8ec;
        }

        /* INFO */
        .info-box {
            max-width: 1000px;
            margin-top: 20px;
            background: #f1edff;
            border: 1px solid #ddd4ff;
            border-radius: 14px;
            padding: 18px 20px;
            color: #51418a;
            font-size: 13px;
            line-height: 1.7;
        }

        /* RESPONSIVE */
        @media (max-width: 900px) {
            .sidebar {
                width: 210px;
            }

            .main {
                margin-left: 210px;
                width: calc(100% - 210px);
                padding: 22px;
            }

            .form-grid {
                grid-template-columns: 1fr;
            }

            .form-group.full {
                grid-column: auto;
            }
        }

        @media (max-width: 600px) {
            .layout {
                display: block;
            }

            .sidebar {
                position: static;
                width: 100%;
                border-right: none;
                border-bottom: 1px solid #eee;
            }

            .main {
                margin-left: 0;
                width: 100%;
                padding: 16px;
            }

            .topbar {
                align-items: flex-start;
                flex-direction: column;
            }

            .form-card {
                padding: 20px;
            }

            .actions .btn {
                width: 100%;
            }
        }
    </style>
</head>

<body>

<div class="layout">

    <!-- SIDEBAR -->
    <aside class="sidebar">

        <div class="brand">THOUHA MART</div>
        <div class="seller-label">Seller Panel</div>

        <nav class="menu">

            <a href="${pageContext.request.contextPath}/seller/dashboard">
                Dashboard
            </a>

            <a href="${pageContext.request.contextPath}/seller/products/add"
               class="active">
                Add Product
            </a>

            <a href="${pageContext.request.contextPath}/seller/products">
                My Products
            </a>

            <a href="${pageContext.request.contextPath}/seller/orders">
                Orders
            </a>

            <a href="${pageContext.request.contextPath}/seller/sales">
                Sales
            </a>

            <a href="${pageContext.request.contextPath}/logout"
               class="logout">
                Logout
            </a>

        </nav>
    </aside>

    <!-- MAIN -->
    <main class="main">

        <!-- TOP BAR -->
        <div class="topbar">

            <div>
                <h1>Add New Product</h1>
                <p>Add your product details and upload its photo.</p>
            </div>

            <div class="seller-badge">
                Seller Account
            </div>

        </div>

        <!-- PRODUCT FORM -->
        <div class="form-card">

            <h2>Product Information</h2>

            <p class="form-description">
                Enter accurate product details and select a clear product
                image from your computer.
            </p>

            <!-- ERROR MESSAGE -->
            <c:if test="${not empty error}">
                <div class="error-box">
                    <c:out value="${error}"/>
                </div>
            </c:if>

            <!-- SUCCESS MESSAGE -->
            <c:if test="${not empty success}">
                <div class="success-box">
                    <c:out value="${success}"/>
                </div>
            </c:if>

            <!-- FORM -->
            <form
                id="productForm"
                action="${pageContext.request.contextPath}/seller/products/add"
                method="post"
                enctype="multipart/form-data">

                <div class="form-grid">

                    <!-- PRODUCT NAME -->
                    <div class="form-group full">

                        <label for="name">Product Name *</label>

                        <input
                            type="text"
                            id="name"
                            name="name"
                            placeholder="Example: Wireless Bluetooth Headphones"
                            maxlength="150"
                            required>

                    </div>

                    <!-- CATEGORY -->
                    <div class="form-group">

                        <label for="categoryId">Category *</label>

                        <select
                            id="categoryId"
                            name="categoryId"
                            required>

                            <option value="">Select a category</option>

                            <c:forEach var="category" items="${categories}">
                                <option value="${category.id}">
                                    <c:out value="${category.name}"/>
                                </option>
                            </c:forEach>

                        </select>

                        <c:if test="${empty categories}">
                            <span class="hint">
                                No categories are currently available.
                                Please contact the administrator.
                            </span>
                        </c:if>

                    </div>

                    <!-- PRICE -->
                    <div class="form-group">

                        <label for="price">Price (₹) *</label>

                        <input
                            type="number"
                            id="price"
                            name="price"
                            placeholder="Example: 1999.00"
                            min="0.01"
                            step="0.01"
                            required>

                    </div>

                    <!-- STOCK -->
                    <div class="form-group">

                        <label for="stock">Available Stock *</label>

                        <input
                            type="number"
                            id="stock"
                            name="stock"
                            placeholder="Example: 50"
                            min="0"
                            step="1"
                            required>

                    </div>

                    <!-- PRODUCT IMAGE -->
                    <div class="form-group full">

                        <label for="productImage">Product Image *</label>

                        <div class="upload-area">

                            <div class="upload-icon">📷</div>

                            <div class="upload-title">
                                Upload Your Product Photo
                            </div>

                            <div class="upload-description">
                                Select an image from your computer.
                                JPG, PNG or WEBP · Maximum 5 MB
                            </div>

                            <label
                                for="productImage"
                                class="choose-file-btn">
                                Choose Image
                            </label>

                            <input
                                class="file-input"
                                type="file"
                                id="productImage"
                                name="productImage"
                                accept=".jpg,.jpeg,.png,.webp,image/jpeg,image/png,image/webp"
                                required>

                            <div
                                class="file-name"
                                id="fileName"
                                aria-live="polite">
                            </div>

                            <div class="preview-container" id="previewContainer">

                                <img
                                    class="image-preview"
                                    id="imagePreview"
                                    alt="Selected product image preview">

                                <button
                                    type="button"
                                    class="remove-image"
                                    id="removeImage">
                                    Remove Image
                                </button>

                            </div>

                        </div>

                        <span class="hint">
                            Choose a clear image of the product.
                            The selected photo will be previewed before submission.
                        </span>

                    </div>

                    <!-- DESCRIPTION -->
                    <div class="form-group full">

                        <label for="description">Product Description</label>

                        <textarea
                            id="description"
                            name="description"
                            maxlength="5000"
                            placeholder="Describe the product features, size, specifications and other details."></textarea>

                    </div>

                </div>

                <!-- BUTTONS -->
                <div class="actions">

                    <button
                        type="submit"
                        class="btn btn-primary">
                        + Add Product
                    </button>

                    <a
                        href="${pageContext.request.contextPath}/seller/products"
                        class="btn btn-secondary">
                        Cancel
                    </a>

                </div>

            </form>

        </div>

        <!-- SELLER TIP -->
        <div class="info-box">

            <strong>Seller tip:</strong>

            Upload a clear product image, provide an accurate price,
            maintain the correct stock quantity and write a useful
            description to help customers make informed decisions.

        </div>

    </main>

</div>

<!-- IMAGE PREVIEW AND VALIDATION -->
<script>
    const imageInput = document.getElementById("productImage");
    const imagePreview = document.getElementById("imagePreview");
    const previewContainer = document.getElementById("previewContainer");
    const fileName = document.getElementById("fileName");
    const removeImageButton = document.getElementById("removeImage");
    const productForm = document.getElementById("productForm");

    let previewObjectUrl = null;

    imageInput.addEventListener("change", function () {
        const file = this.files[0];

        if (!file) {
            clearImagePreview();
            return;
        }

        const allowedTypes = [
            "image/jpeg",
            "image/png",
            "image/webp"
        ];

        if (!allowedTypes.includes(file.type)) {
            alert("Please select a JPG, PNG or WEBP image.");
            this.value = "";
            clearImagePreview();
            return;
        }

        if (file.size > 5 * 1024 * 1024) {
            alert("Image size must be 5 MB or less.");
            this.value = "";
            clearImagePreview();
            return;
        }

        if (previewObjectUrl) {
            URL.revokeObjectURL(previewObjectUrl);
        }

        previewObjectUrl = URL.createObjectURL(file);

        imagePreview.src = previewObjectUrl;
        previewContainer.style.display = "block";
        fileName.textContent = "Selected: " + file.name;
    });

    function clearImagePreview() {
        if (previewObjectUrl) {
            URL.revokeObjectURL(previewObjectUrl);
            previewObjectUrl = null;
        }

        imagePreview.removeAttribute("src");
        previewContainer.style.display = "none";
        fileName.textContent = "";
    }

    removeImageButton.addEventListener("click", function () {
        imageInput.value = "";
        clearImagePreview();
    });

    productForm.addEventListener("submit", function (event) {
        const file = imageInput.files[0];

        if (!file) {
            event.preventDefault();
            alert("Please select a product image.");
            imageInput.focus();
            return;
        }

        if (file.size > 5 * 1024 * 1024) {
            event.preventDefault();
            alert("Image size must be 5 MB or less.");
        }
    });
</script>

</body>
</html>