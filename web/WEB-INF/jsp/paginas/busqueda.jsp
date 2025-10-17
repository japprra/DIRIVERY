<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/jsp/menu.jsp" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Resultados de Búsqueda</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Iconos -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">

    <!-- CSS personalizado -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/paginas.css">
</head>
<body>

<div class="container mt-4">
    <h2 class="mb-4 text-center text-primary fw-bold">
        <i class="bi bi-search"></i> Resultados de Búsqueda
    </h2>

    <!-- Formulario de búsqueda -->
    <form class="d-flex justify-content-center mb-4" role="search" method="get" action="${pageContext.request.contextPath}/busqueda.htm">
        <input class="form-control me-2 w-50 shadow-sm" type="search" name="query" placeholder="Buscar productos..." aria-label="Buscar">
        <button class="btn btn-primary px-4 shadow-sm" type="submit"><i class="bi bi-search"></i> Buscar</button>
    </form>

    <div class="row g-4">
        <c:choose>
            <c:when test="${not empty productos}">
                <c:forEach var="producto" items="${productos}">
                    <div class="col-12 col-sm-6 col-md-4 col-lg-3">
                        <div class="card producto-card shadow-lg border-0 h-100">
                            <img src="${producto.imagen}" class="card-img-top producto-img" alt="${producto.nombre}">
                            <div class="card-body d-flex flex-column text-center">
                                <h5 class="card-title text-primary fw-semibold">${producto.nombre}</h5>
                                <p class="text-muted small">${producto.descripcion}</p>
                                <p class="precio mb-3"><strong>S/. ${producto.precio}</strong></p>

                                <a href="${pageContext.request.contextPath}/carrito/agregar.htm?id=${producto.idprod}"
                                   class="mt-auto btn btn-success btn-sm rounded-pill shadow-sm">
                                    <i class="bi bi-cart-plus"></i> Agregar al carrito
                                </a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="col-12">
                    <div class="alert alert-warning text-center shadow-sm">
                        <i class="bi bi-exclamation-triangle"></i> No se encontraron productos con esa búsqueda.
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<!-- Footer -->
<footer class="footer bg-dark text-light py-3 mt-5">
    <div class="container text-center">
        © 2025 <strong>Mi Perú</strong>. Todos los derechos reservados.
    </div>
</footer>

<!-- Bootstrap JS -->
</body>
</html>
