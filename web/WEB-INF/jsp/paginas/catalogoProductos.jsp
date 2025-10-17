<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"><!--  -->
    
 <link rel="stylesheet" href="${pageContext.request.contextPath}/css/paginas.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilosMenu.css">
</head>
<body>

<div class="container mt-5 mb-5">
    <h2 class="mb-5 text-center text-primary fw-bold">
        <i class="bi bi-bag-check"></i> Catálogo de Productos
    </h2>

    <div class="row g-4">
        <c:forEach var="producto" items="${productos}">
            <div class="col-12 col-sm-6 col-md-4 col-lg-3">
                <div class="card producto-card shadow-lg border-0 h-100">
                    <img 
                        src="${empty producto.imagen ? pageContext.request.contextPath+'/img/default.png' : producto.imagen}" 
                        alt="${producto.nombre}" 
                        class="card-img-top producto-img">
                    
                    <div class="card-body d-flex flex-column text-center">
                        <h5 class="card-title">${producto.nombre}</h5>
                        <p class="precio mb-2"><strong>S/. ${producto.precio}</strong></p>

                        <!-- Cantidad disponible -->
                        <c:choose>
                            <c:when test="${producto.cantidad > 0}">
                                <p class="card-text text-success mb-2 small">
                                    <i class="bi bi-check-circle"></i> Disponible: 
                                    <strong>${producto.cantidad}</strong> unidades
                                </p>
                            </c:when>
                            <c:otherwise>
                                <p class="card-text text-danger mb-2 small">
                                    <i class="bi bi-x-circle"></i> Agotado
                                </p>
                            </c:otherwise>
                        </c:choose>

                        <c:if test="${not empty producto.descripcion}">
                            <p class="card-text text-muted mb-3 small">${producto.descripcion}</p>
                        </c:if>

                        <!-- Botón de acción -->
                        <div class="mt-auto">
                            <c:choose>
                                <c:when test="${producto.cantidad > 0}">
                                    <a href="${pageContext.request.contextPath}/carrito/agregar.htm?id=${producto.idprod}&redirect=index"
                                       class="btn btn-success btn-sm rounded-pill shadow-sm">
                                        <i class="bi bi-cart-plus"></i> Agregar al carrito
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <button class="btn btn-secondary btn-sm rounded-pill shadow-sm" disabled>
                                        <i class="bi bi-ban"></i> Agotado
                                    </button>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>



