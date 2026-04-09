package edu.ifsp.loja.persistencia;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import edu.ifsp.loja.modelo.Cliente;

public class ClienteDAO {
	
	public Cliente findById(int id) {
		Cliente cliente = new Cliente();

		try {
			
			Connection conn = DatabaseConnector.getConnection();
			
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(
					"SELECT id, nome, email FROM cliente WHERE id = " + id);
			
			if (rs.next()) {
				cliente.setId(rs.getInt("id"));
				cliente.setNome(rs.getString("nome"));
				cliente.setEmail(rs.getString("email"));
			}
			
			rs.close();
			stmt.close();
			conn.close();
			
		} catch (SQLException e) {
			throw new DataAccessException(e);
		}
		
		return cliente;
	}

	public List<Cliente> find(String nome, boolean ativo) {
		List<Cliente> resultado = new ArrayList<>();

		try {
			
			Connection conn = DatabaseConnector.getConnection();
			
			PreparedStatement ps = conn.prepareStatement("SELECT id, nome, email, ativo FROM cliente WHERE nome LIKE ? AND ativo = ?");			
			ps.setString(1, "%" + nome + "%");
			ps.setBoolean(2, ativo);
			ResultSet rs = ps.executeQuery();
			
			while (rs.next()) {
				Cliente cliente = new Cliente();
				cliente.setId(rs.getInt("id"));
				cliente.setNome(rs.getString("nome"));
				cliente.setEmail(rs.getString("email"));
				cliente.setAtivo(rs.getBoolean("ativo"));
				resultado.add(cliente);
			}
			
			rs.close();
			ps.close();
			conn.close();
			
		} catch (SQLException e) {
			throw new DataAccessException(e);
		}

		
		return resultado;
	}
}
