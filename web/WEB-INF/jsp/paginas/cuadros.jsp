<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Catálogo de Cuadros | Industria y Manufactura</title>
    
    <!-- Iconos de Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Bootstrap 5 CSS -->
    <link 
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" 
      rel="stylesheet"
      crossorigin="anonymous"
    >

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
        <h2 class="text-center mb-4">Catálogo de Cuadros - Industria y Manufactura</h2>

        <div class="row g-4">
            <c:choose>
                <c:when test="${not empty productos}">
                    <c:forEach var="producto" items="${productos}">
                        <div class="col-12 col-sm-6 col-md-4 col-lg-3">
                            <div class="producto-card h-100 text-center p-3 shadow-sm rounded bg-white">
                                
                                <!-- Imagen -->
<img src="${producto.imagen}" 
     alt="${producto.nombre}" 
     class="producto-img mb-2 img-fluid rounded" />

<!-- Nombre -->
<h5 class="card-title">${producto.nombre}</h5>

<!-- 🔹 Proveedor -->
<c:choose>
    <c:when test="${not empty producto.proveedorNombre}">
        <p class="text-muted mb-1">
            <i class="bi bi-truck"></i> Proveedor: 
            <strong>${producto.proveedorNombre}</strong>
        </p>
    </c:when>
    <c:otherwise>
        <p class="text-muted mb-1">
            <i class="bi bi-truck"></i> Sin proveedor
        </p>
    </c:otherwise>
</c:choose>

<!-- Precio -->
<p>Precio: <strong>S/. ${producto.precio}</strong></p>

<!-- Stock -->
<c:choose>
    <c:when test="${producto.cantidad > 0}">
        <p class="text-success mb-2">
            Disponible: <strong>${producto.cantidad}</strong> unidades
        </p>
    </c:when>
    <c:otherwise>
        <p class="text-danger mb-2">Agotado</p>
    </c:otherwise>
</c:choose>


                                

                                <!-- Botón agregar o agotado -->
                                <c:choose>
                                    <c:when test="${producto.cantidad > 0}">
                                        <a href="${pageContext.request.contextPath}/carrito/agregar.htm?id=${producto.idprod}&redirect=cuadros"
                                           class="btn btn-success btn-sm w-100">
                                           <i class="bi bi-cart-plus"></i> Agregar al carrito
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <button class="btn btn-secondary btn-sm w-100" disabled>
                                            <i class="bi bi-x-circle"></i> Agotado
                                        </button>
                                    </c:otherwise>
                                </c:choose>

                            </div>
                        </div>
                    </c:forEach>
                </c:when>

                <c:otherwise>
                    <div class="col-12">
                        <div class="alert alert-info text-center">
                            No hay productos disponibles en esta categoría.
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer bg-light py-3 mt-5 border-top">
        <div class="container text-center small text-muted">
            © 2025 Mi Perú. Todos los derechos reservados.
        </div>
    </footer>

</body>
</html>
