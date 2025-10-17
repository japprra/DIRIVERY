<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Productos Artesanía y Cultura</title>

    <!-- Bootstrap CSS -->
    <link 
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" 
        rel="stylesheet" crossorigin="anonymous">

    <!-- Iconos de Bootstrap -->
    <link 
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" 
        rel="stylesheet">

    <!-- Vue.js -->
    <script src="https://unpkg.com/vue@3"></script>

    <!-- CSS personalizado -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/paginas.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilosMenu.css">

    <style>
        .producto-card {
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            transition: transform 0.2s ease;
        }
        .producto-card:hover {
            transform: scale(1.03);
        }
        .producto-img {
            width: 100%;
            height: 200px;
            object-fit: cover;
            border-radius: 8px;
        }
        .proveedor {
            font-size: 0.9rem;
            color: #555;
            background-color: #f8f9fa;
            padding: 4px 8px;
            border-radius: 5px;
            display: inline-block;
            margin-bottom: 6px;
        }
    </style>
</head>
<body class="bg-light">

    <%@ include file="/WEB-INF/jsp/menu.jsp" %>

    <div class="container mt-4">
        <h2 class="mb-4 text-center text-primary">Productos Artesanía y Cultura</h2>
        
        <div class="row g-4">
            <c:forEach var="producto" items="${productos}">
                <div class="col-12 col-sm-6 col-md-4 col-lg-3">
                    <div class="producto-card text-center p-3 h-100 d-flex flex-column">

                        <!-- Imagen -->
                        <img src="${producto.imagen}" alt="${producto.nombre}" class="producto-img mb-3" />

                        <!-- Nombre -->
                        <h5 class="card-title mb-2">${producto.nombre}</h5>

                        <!-- Proveedor -->
                        <c:choose>
                            <c:when test="${not empty producto.proveedorNombre}">
                                <p class="proveedor">
                                    <i class="bi bi-shop"></i> ${producto.proveedorNombre}
                                </p>
                            </c:when>
                            <c:otherwise>
                                <p class="proveedor text-muted"><i class="bi bi-shop"></i> Sin proveedor</p>
                            </c:otherwise>
                        </c:choose>

                        <!-- Precio -->
                        <p>Precio: <strong>S/. ${producto.precio}</strong></p>

                        <!-- Cantidad -->
                        <c:choose>
                            <c:when test="${producto.cantidad > 0}">
                                <p class="text-success mb-2">Disponible: <strong>${producto.cantidad}</strong> unidades</p>
                            </c:when>
                            <c:otherwise>
                                <p class="text-danger mb-2">Agotado</p>
                            </c:otherwise>
                        </c:choose>

                        <!-- Descripción -->
                        <c:if test="${not empty producto.descripcion}">
                            <p class="card-text small text-muted flex-grow-1">${producto.descripcion}</p>
                        </c:if>

                        <!-- Botón agregar o agotado -->
                        <c:choose>
                            <c:when test="${producto.cantidad > 0}">
                                <a href="${pageContext.request.contextPath}/carrito/agregar.htm?id=${producto.idprod}&redirect=polo"
                                   class="mt-auto btn btn-success btn-sm">
                                   <i class="bi bi-cart-plus"></i> Agregar al carrito
                                </a>
                            </c:when>
                            <c:otherwise>
                                <button class="mt-auto btn btn-secondary btn-sm" disabled>
                                    <i class="bi bi-x-circle"></i> Agotado
                                </button>
                            </c:otherwise>
                        </c:choose>

                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer bg-light py-3 mt-5">
        <div class="container text-center text-muted">
            © 2025 Mi Perú. Todos los derechos reservados.
        </div>
    </footer>

</body>
</html>

