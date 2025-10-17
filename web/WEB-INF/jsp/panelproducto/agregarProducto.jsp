<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/jsp/panelproducto/menuAdmin.jsp" %>

<!-- CONTENIDO PRINCIPAL DENTRO DE .admin-content -->
<div class="admin-content">
  <div class="container mt-0">
    <h2 class="text-primary mb-4">Agregar Nuevo Producto</h2>

    <form method="post" action="${pageContext.request.contextPath}/agregarProducto.htm">
      
      <div class="mb-3">
        <label for="clave" class="form-label">Clave</label>
        <input type="text" class="form-control" id="clave" name="clave" required>
      </div>

      <div class="mb-3">
        <label for="nombre" class="form-label">Nombre</label>
        <input type="text" class="form-control" id="nombre" name="nombre" required>
      </div>

      <div class="mb-3">
        <label for="precio" class="form-label">Precio</label>
        <input type="number" step="0.01" class="form-control" id="precio" name="precio" required>
      </div>

      <div class="mb-3">
        <label for="cantidad" class="form-label">Cantidad</label>
        <input type="number" class="form-control" id="cantidad" name="cantidad" required>
      </div>

      <div class="mb-3">
        <label for="imagen" class="form-label">URL Imagen</label>
        <input type="url" class="form-control" id="imagen" name="imagen" placeholder="https://...">
      </div>

      <!-- ? NUEVO CAMPO: Seleccionar proveedor -->
      <div class="mb-3">
        <label for="idproveedor" class="form-label">Proveedor</label>
        <select class="form-select" id="idproveedor" name="idproveedor" required>
          <option value="">-- Selecciona un proveedor --</option>
          <c:forEach var="prov" items="${proveedores}">
            <option value="${prov.idproveedor}">${prov.nombre}</option>
          </c:forEach>
        </select>
      </div>
      <!-- ? Fin nuevo campo -->

      <div class="d-flex justify-content-between">
        <a href="${pageContext.request.contextPath}/panelProductos.htm" class="btn btn-secondary">
          Volver
        </a>
        <button type="submit" class="btn btn-success">Agregar Producto</button>
      </div>
    </form>
  </div>
</div>
