/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.EMS.controller.filter;

import com.EMS.service.EmployeeService;
import com.EMS.utility.FunctionResponse;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import org.apache.commons.codec.binary.Base64;
import org.json.JSONObject;

/**
 *
 * @author Andres Alarcon
 */
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        String authHeader = req.getHeader("Authorization");
        res.setHeader("Authorization", authHeader);
        System.out.println("AuthHeader es "+authHeader);        

        /*if (authHeader == null) {
            Object tokenFromSession = req.getSession().getAttribute("token");
            if (tokenFromSession != null) {
                authHeader = tokenFromSession.toString();
            }
        }*/
        String uri = req.getRequestURI();
        String url = req.getRequestURL().toString();
        String servletPath = req.getServletPath();
        System.out.println("INTENTA ACCEDER A:");
        System.out.println(" - URI: " + uri);
        System.out.println(" - Full URL: " + url);
        System.out.println(" - Servlet Path: " + servletPath);
        System.out.println("Entrra al Filtro authHeader " + authHeader);
        if (authHeader != null && authHeader.startsWith("Bearer ")) {
            try {
                com.EMS.utility.FunctionResponse fresponse = leerToken(authHeader);
                if (servletPath.endsWith("jsp")) {
                    if (fresponse.getStatus()) {
                        HttpSession session = req.getSession();
                        session.setAttribute("token", authHeader);
                        //session.setAttribute("password", password);
                        session.setAttribute("firstname", fresponse.getResponse());
                        session.setAttribute("role", fresponse.getRole());
                        session.setAttribute("userId", fresponse.getEmployeeId());
                        String activityStatus = "FALSE";
                        if (fresponse.getActivityStatus()) {
                            activityStatus = "TRUE";
                        } else {
                            activityStatus = "FALSE";
                        }
                        session.setAttribute("activityStatus", activityStatus);
                        com.EMS.entity.Registration register = EmployeeService.getUserDetails(fresponse.getEmployeeId());
                        if (fresponse.getRole() == 1) {
                            request.setAttribute("register", register);
                            System.out.println("Redirige A");
                            RequestDispatcher rs = request.getRequestDispatcher("adminDashboard.jsp");
                            rs.forward(request, response);
                            return;
                        } else if (fresponse.getRole() == 2) {
                            System.out.println("Redirige B");
                            request.setAttribute("register", register);
                            RequestDispatcher rs = request.getRequestDispatcher("managerDashboard.jsp");
                            rs.forward(request, response);
                            return;
                        } else {
                            System.out.println("Redirige C");
                            request.setAttribute("register", register);
                            RequestDispatcher rs = request.getRequestDispatcher("employeeDashboard.jsp");
                            rs.forward(request, response);
                            return;
                        }
                    } else {
                        System.out.println("Ocurrio un error");
                        request.setAttribute("loginerror", fresponse.getResponse());
                        RequestDispatcher rs = request.getRequestDispatcher("login.jsp");
                        rs.forward(request, response);
                        return;
                    }
                } else {
                    chain.doFilter(request, response);
                    return;
                }
            } catch (Exception ex) {
                System.out.println("Error " + ex.getMessage());
            }
        }
        res.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Token inválido o ausente.");
    }

    private com.EMS.utility.FunctionResponse leerToken(String token) {
        com.EMS.utility.FunctionResponse fresResponse = new FunctionResponse();
        try {
            String[] parts = token.split("\\.");
            if (parts.length < 2) {
                System.out.println("Token inválido");
                throw new Exception("Token inválido");
            }

            String payload = parts[1];
            byte[] decodedBytes = Base64.decodeBase64(payload);
            String jsonPayload = new String(decodedBytes, "UTF-8");
            JSONObject json = new JSONObject(jsonPayload);

            String name = json.optString("firstname");
            String sub = json.optString("username");
            fresResponse.setStatus(true);
            fresResponse.setEmployeeId(Integer.valueOf(json.optString("userId")).intValue());//EmployeeIduserId
            fresResponse.setResponse(json.optString("firstname"));//Firstname
            fresResponse.setRole(Integer.valueOf(json.optString("role")).intValue());//Role
            fresResponse.setManagerId(1);//ManagerId
            fresResponse.setActivityStatus(json.optString("userId") == "TRUE" ? Boolean.TRUE : Boolean.FALSE);
            System.out.println("Claim 'firstname': " + name);
            System.out.println("Claim 'username': " + sub);
            return fresResponse;
        } catch (Exception ex) {
            System.out.println("Error leyendo toklen " + ex.getMessage());
        }
        return fresResponse;
    }

    @Override
    public void destroy() {
    }
}
