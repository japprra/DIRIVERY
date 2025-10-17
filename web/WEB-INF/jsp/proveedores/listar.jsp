<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/jsp/panelproducto/menuAdmin.jsp" %>

<div class="admin-content">
  <div class="container mt-0">
    <h2 class="text-primary mb-4">Lista de Proveedores</h2>

    <div class="mb-3 text-end">
      <a href="${pageContext.request.contextPath}/proveedores/nuevo" class="btn btn-success">Agregar Nuevo</a>
    </div>

    <table class="table table-striped table-hover">
      <thead class="table-dark">
        <tr>
          <th>ID</th>
          <th>Nombre</th>
          <th>Contacto</th>
          <th>Teléfono</th>
          <th>Email</th>
          <th>Dirección</th>
          <th>Acciones</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="p" items="${proveedores}">
          <tr>
            <td>${p.idproveedor}</td>
            <td>${p.nombre}</td>
            <td>${p.contacto}</td>
            <td>${p.telefono}</td>
            <td>${p.email}</td>
            <td>${p.direccion}</td>
            <td>
              <a href="${pageContext.request.contextPath}/proveedores/editar/${p.idproveedor}" class="btn btn-warning btn-sm">Editar</a>
              <a href="${pageContext.request.contextPath}/proveedores/eliminar/${p.idproveedor}" class="btn btn-danger btn-sm"
                 onclick="return confirm('¿Seguro que deseas eliminar este proveedor?');">Eliminar</a>
            </td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
  </div>
</div>
