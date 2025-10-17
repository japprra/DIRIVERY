<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ include file="/WEB-INF/jsp/panelproducto/menuAdmin.jsp" %>

<div class="container mt-5">
  <h2 class="text-primary mb-4">
    <c:choose>
      <c:when test="${proveedor.idproveedor != null}">Editar Proveedor</c:when>
      <c:otherwise>Nuevo Proveedor</c:otherwise>
    </c:choose>
  </h2>

  <form:form method="post" modelAttribute="proveedor"
             action="${pageContext.request.contextPath}/proveedores/${proveedor.idproveedor != null ? 'actualizar' : 'guardar'}">

    <div class="mb-3">
      <form:label path="nombre">Nombre</form:label>
      <form:input path="nombre" class="form-control"/>
    </div>

    <div class="mb-3">
      <form:label path="contacto">Contacto</form:label>
      <form:input path="contacto" class="form-control"/>
    </div>

    <div class="mb-3">
      <form:label path="telefono">Teléfono</form:label>
      <form:input path="telefono" class="form-control"/>
    </div>

    <div class="mb-3">
      <form:label path="email">Email</form:label>
      <form:input path="email" class="form-control"/>
    </div>

    <div class="mb-3">
      <form:label path="direccion">Dirección</form:label>
      <form:input path="direccion" class="form-control"/>
    </div>

    <button type="submit" class="btn btn-primary">Guardar</button>
    <a href="${pageContext.request.contextPath}/proveedores/listar" class="btn btn-secondary">Cancelar</a>
  </form:form>
</div>
