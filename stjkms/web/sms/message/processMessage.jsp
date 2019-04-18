<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="java.io.*,java.util.StringTokenizer"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>


<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Process Message</title>
        <%
    String email = (String) session.getAttribute("email");
    if (null != email) { %>

        <%
            String previousPage = request.getHeader("referer");
            if (previousPage != null) {
        %>

        <sql:setDataSource var="con" driver="com.mysql.jdbc.Driver"
                           url="jdbc:mysql://localhost:3306/stjkms"
                           user="root" password="Kripalu@1008" />

        <sql:query var="result" dataSource="${con}"
                   sql="select * from contacts order by Name" />

        <c:forEach items="${result.rows}" var="row">
            <c:import url="http://bulkpush.mytoday.com/BulkSms/SingleMsgApi"
                      var="result">
                <c:param name="feedid" value="364413" />
                <c:param name="senderid" value="STJKMS" />
                <c:param name="username" value="9869422666" />
                <c:param name="password" value="rkt@1401" />
                <c:param name="To" value="${row.Number}" />
                <c:param name="Text"
                         value="Radhey Radhey ${row.Name} ${row.Adjective} ${param.inputmessage}" />
            </c:import>
        </c:forEach>

        <sql:update var="result_update" dataSource="${con}"
                    sql="insert into send_messages(Message) values(?)">
            <sql:param value="${param.inputmessage}" />
        </sql:update>

        <jsp:forward page="successMessageSend.jsp" />
        <%
            }
        %>
        <jsp:forward page="../../logout.jsp" />
    </head>

    <%        } else { %>
    <a class="btn btn-lg btn-primary btn-block text-uppercase" href="../../logout.jsp" role="button"> Please Login First ...</a>
    <%}
    %>


</html>