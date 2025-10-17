<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/jsp/panelproducto/menuAdmin.jsp" %>
<c:if test="${sessionScope.usuario != null && sessionScope.usuario.role == 'ADMIN'}">
    <!-- Mostrar contenido solo para admin -->
</c:if>
<div class="admin-content">
  <div class="container mt-0">

    <!-- Control acceso: solo admin puede ver -->
    <c:if test="${sessionScope.usuario != null && sessionScope.usuario.role == 'ADMIN'}">

      <h2 class="text-primary mb-4">Lista de Usuarios Registrados</h2>

      <div class="table-responsive">
        <table class="table table-bordered table-hover table-striped align-middle">
          <thead class="table-dark">
            <tr>
              <th>ID</th>
              <th>Cuenta</th>
              <th>Nombre</th>
              <th>Email</th>
              <th>Rol</th>
              <th>Acciones</th> <!-- columna para botones -->
            </tr>
          </thead>
          <tbody>
            <c:forEach var="usuario" items="${listaUsuarios}">
              <tr>
                <td>${usuario.iduser}</td>
                <td>${usuario.cuenta}</td>
                <td>${usuario.nombre}</td>
                <td>${usuario.email}</td>
                <td>
                  <span class="badge ${usuario.role == 'ADMIN' ? 'bg-danger' : 'bg-secondary'}">
                    ${usuario.role}
                  </span>
                </td>
                <td>
                  <!-- Form para eliminar usuario -->
                  <form action="${pageContext.request.contextPath}/eliminarUsuario.htm" method="post" style="display:inline;">
                    <input type="hidden" name="iduser" value="${usuario.iduser}" />
                    <button type="submit" class="btn btn-sm btn-danger" 
                      onclick="return confirm('¿Eliminar usuario ${usuario.cuenta}? Esta acción no se puede deshacer.')">
                      Eliminar
                    </button>
                  </form>
                </td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </div>

      <div class="mt-4">
        <a href="${pageContext.request.contextPath}/panelProductos.htm" class="btn btn-secondary">
          Volver al Panel
        </a>
      </div>

    </c:if>

    <!-- Mensaje si no es admin -->
    <c:if test="${sessionScope.usuario == null || sessionScope.usuario.role != 'ADMIN'}">
      <div class="alert alert-danger mt-4" role="alert">
        Acceso denegado. No tienes permiso para ver esta página.
      </div>
      <a href="${pageContext.request.contextPath}/login.htm" class="btn btn-primary">
        Iniciar sesión
      </a>
    </c:if>

  </div>
</div>