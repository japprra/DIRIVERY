<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/jsp/panelproducto/menuAdmin.jsp" %>

<!-- CONTENIDO PRINCIPAL -->
<div class="admin-content">
  <div class="container mt-0">
    <h2 class="text-primary mb-4">Editar Proveedor</h2>

    <form method="post" action="${pageContext.request.contextPath}/proveedores/actualizar">

      <!-- Campo oculto para el ID -->
      <input type="hidden" name="idproveedor" value="${proveedor.idproveedor}"/>

      <div class="mb-3">
        <label for="nombre" class="form-label">Nombre</label>
        <input type="text" class="form-control" id="nombre" name="nombre" value="${proveedor.nombre}" required>
      </div>

      <div class="mb-3">
        <label for="contacto" class="form-label">Contacto</label>
        <input type="text" class="form-control" id="contacto" name="contacto" value="${proveedor.contacto}" required>
      </div>

      <div class="mb-3">
        <label for="telefono" class="form-label">Teléfono</label>
        <input type="text" class="form-control" id="telefono" name="telefono" value="${proveedor.telefono}" required>
      </div>

      <div class="mb-3">
        <label for="email" class="form-label">Correo Electrónico</label>
        <input type="email" class="form-control" id="email" name="email" value="${proveedor.email}">
      </div>

      <div class="mb-3">
        <label for="direccion" class="form-label">Dirección</label>
        <input type="text" class="form-control" id="direccion" name="direccion" value="${proveedor.direccion}">
      </div>

      <div class="d-flex justify-content-between">
        <a href="${pageContext.request.contextPath}/proveedores/listar" class="btn btn-secondary">
          Cancelar
        </a>
        <button type="submit" class="btn btn-primary">Guardar Cambios</button>
      </div>
    </form>
  </div>
</div>
