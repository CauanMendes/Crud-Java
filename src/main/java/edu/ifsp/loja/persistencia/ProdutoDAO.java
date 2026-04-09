package edu.ifsp.loja.persistencia;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import edu.ifsp.loja.modelo.Produto;

public class ProdutoDAO {
	public Produto findById(int id) {
		Produto produto = new Produto();
		
		try {
			
			Connection conn = DatabaseConnector.getConnection();
			
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(
					"SELECT id, descricao, preco FROM produto WHERE id = " + id);
			
			if (rs.next()) {
				produto.setId(rs.getInt("id"));
				produto.setDescricao(rs.getString("descricao"));
				produto.setPreco(rs.getDouble("preco"));
			}
			
			rs.close();
			stmt.close();
			conn.close();
			
		} catch (SQLException e) {
			throw new DataAccessException(e);
		}
		
		return produto;
	}

	public List<Produto> findAll() {
		List<Produto> produtos = new ArrayList<>();
		
		try {
			
			Connection conn = DatabaseConnector.getConnection();
			
			Statement stmt = conn.createStatement();
			String sql = "SELECT id, descricao, preco FROM produto;";
			ResultSet rs = stmt.executeQuery(sql);
		
			while (rs.next()) {
				Produto p = new Produto();
				p.setId(rs.getInt("id"));
				p.setDescricao(rs.getString("descricao"));
				p.setPreco(rs.getDouble("preco"));
				produtos.add(p);
			}
			
			rs.close();
			stmt.close();
			conn.close();
			
		} catch (SQLException e) {
			throw new DataAccessException(e);
		}
		
		
		return produtos;
	}
	
	public int totalItens(String descricao, double precoMinimo, double precoMaximo) {
		int total = 0;
		
try {
			
			Connection conn = DatabaseConnector.getConnection();
			
			PreparedStatement ps = conn.prepareStatement(
					"SELECT COUNT(*) FROM produto "
					+ "WHERE descricao LIKE ? "
					+ "	AND preco BETWEEN ? AND ?");
			
			ps.setString(1, "%" + descricao + "%");
			ps.setDouble(2, precoMinimo);
			ps.setDouble(3, precoMaximo);

						
			ResultSet rs = ps.executeQuery();
		
			if (rs.next()) {
			    // Access the first column (index 1)
			    total = rs.getInt(1); 
			}
			
			System.out.println("Total de itens: " + total);
			
			rs.close();
			ps.close();
			conn.close();
			
		} catch (SQLException e) {
			throw new DataAccessException(e);
		}
		
		
		return total;
	}
	
	public List<Produto> findPaged(
			int page, int pageSize, 
			String descricao, double precoMinimo, double precoMaximo) {

		List<Produto> produtos = new ArrayList<>();
		
		try {
			
			Connection conn = DatabaseConnector.getConnection();
			
			PreparedStatement ps = conn.prepareStatement(
					"SELECT id, descricao, preco "
					+ "FROM produto "
					+ "WHERE descricao LIKE ? "
					+ "	AND preco BETWEEN ? AND ? "
					+ "ORDER BY id "
					+ "LIMIT ?, ?;");
			
			ps.setString(1, "%" + descricao + "%");
			ps.setDouble(2, precoMinimo);
			ps.setDouble(3, precoMaximo);
			ps.setInt(4, (page - 1) * pageSize);
			ps.setInt(5, pageSize);
						
			ResultSet rs = ps.executeQuery();
		
			while (rs.next()) {
				Produto p = new Produto();
				p.setId(rs.getInt("id"));
				p.setDescricao(rs.getString("descricao"));
				p.setPreco(rs.getDouble("preco"));
				produtos.add(p);
			}
			
			rs.close();
			ps.close();
			conn.close();
			
		} catch (SQLException e) {
			throw new DataAccessException(e);
		}
		
		
		return produtos;
		
	}
	
}
