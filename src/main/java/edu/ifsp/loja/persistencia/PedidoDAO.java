package edu.ifsp.loja.persistencia;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import edu.ifsp.loja.modelo.Pedido;

public class PedidoDAO {
	
	public void save(Pedido pedido){
		
		
		
		try(Connection conn = DatabaseConnector.getConnection()){
			
			conn.setAutoCommit(false);
			
			try(
				PreparedStatement ps = conn.prepareStatement(
							"SELECT id, descricao, preco "
									+ "FROM produto "
									+ "WHERE descricao LIKE ? "
									+ "	AND preco BETWEEN ? AND ? "
									+ "ORDER BY id "
									+ "LIMIT ?, ?")) {
				ps.setString(1, "%" + descricao + "%");
				ps.setDouble(2, precoMinimo);
				ps.setDouble(3, precoMaximo);
				ps.setInt(4, (page - 1) * pageSize);
				ps.setInt(5, pageSize);
					
					){
				
				
				
				
						
				conn.commit();
			}catch(SQLException e){
				conn.rollback();
				e.printStackTrace();
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		
		
		
	}
	
}
