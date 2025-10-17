<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- ================== ESTILOS Y FRAMEWORKS ================== -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilosMenu.css">

<!-- ================== LIBRERÍAS JAVASCRIPT ================== -->
<script src="https://unpkg.com/react@18/umd/react.development.js" crossorigin></script>
<script src="https://unpkg.com/react-dom@18/umd/react-dom.development.js" crossorigin></script>
<script src="https://unpkg.com/babel-standalone@6.26.0/babel.min.js"></script>
<script src="https://unpkg.com/vue@3"></script>

<!-- ================== MENÚ PRINCIPAL ================== -->
<%@ include file="/WEB-INF/jsp/menu.jsp" %>

<!-- ================== CONTENIDO PRINCIPAL ================== -->
<div class="container mt-4">
  <h2 class="mb-4 text-center">Carrito de Compras</h2>

  <!-- ===== Carrito vacío ===== -->
  <c:if test="${empty carrito}">
    <div class="alert alert-info text-center">
      Tu carrito está vacío.
    </div>
  </c:if>

  <!-- ===== Carrito con productos ===== -->
  <c:if test="${not empty carrito}">
    
    <!-- Mensaje de error (si lo hay) -->
    <c:if test="${not empty mensajeError}">
      <div class="alert alert-danger text-center">
        ${mensajeError}
      </div>
    </c:if>

    <!-- ===== Tabla de productos ===== -->
    <div class="table-responsive">
      <table class="table align-middle table-striped table-bordered">
        <thead class="table-light">
          <tr>
            <th>Producto</th>
            <th class="text-center">Precio</th>
            <th class="text-center">Cantidad</th>
            <th class="text-end">Subtotal</th>
            <th></th>
          </tr>
        </thead>

        <tbody>
          <c:forEach var="p" items="${carrito}">
            <tr>
              <td>
                <div class="d-flex flex-wrap align-items-center">
                  <img src="${p.imagen}" alt="${p.nombre}" class="img-fluid rounded me-2" style="max-width:60px; height:auto;">
                  <div>
                    <span class="fw-semibold">${p.nombre}</span><br>
                    <!-- ✅ Mostrar proveedor si existe -->
                    <c:if test="${not empty p.proveedorNombre}">
                      <small class="text-muted">Proveedor: ${p.proveedorNombre}</small>
                    </c:if>
                  </div>
                </div>
              </td>

              <td class="text-center">$ ${p.precio}</td>

              <td class="text-center">
                <form action="${pageContext.request.contextPath}/carrito/actualizar.htm" 
                      method="post" 
                      class="d-flex flex-column flex-sm-row align-items-center justify-content-center gap-2">
                  
                  <input type="hidden" name="id" value="${p.idprod}">
                  <input type="number" class="form-control form-control-sm" name="cantidad" value="${p.cantidad}" min="1" style="width:80px;">
                  <button class="btn btn-sm btn-outline-primary w-100 w-sm-auto" type="submit">
                    Actualizar
                  </button>
                </form>
              </td>

              <td class="text-end">$ ${p.precio * p.cantidad}</td>

              <td class="text-end">
                <a href="${pageContext.request.contextPath}/carrito/eliminar.htm?id=${p.idprod}" 
                   class="btn btn-sm btn-outline-danger w-100 w-sm-auto">
                  Quitar
                </a>
              </td>
            </tr>
          </c:forEach>
        </tbody>

        <tfoot>
          <tr>
            <th colspan="3" class="text-end">Total:</th>
            <th class="text-end">$ ${total}</th>
            <th></th>
          </tr>
        </tfoot>
      </table>
    </div>

    <!-- ===== Acciones ===== -->
    <div class="d-flex flex-column flex-sm-row justify-content-between gap-2 mt-3">
      <a href="${pageContext.request.contextPath}/carrito/vaciar.htm" class="btn btn-outline-secondary w-100 w-sm-auto">
        Vaciar carrito
      </a>
      <a href="${pageContext.request.contextPath}/checkout.htm" class="btn btn-success w-100 w-sm-auto">
        Ir a pagar
      </a>
    </div>

  </c:if>
</div>
