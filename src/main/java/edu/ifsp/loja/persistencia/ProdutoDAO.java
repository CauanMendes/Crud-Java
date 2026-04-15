package edu.ifsp.loja.persistencia;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import edu.ifsp.loja.modelo.Produto;

public class ProdutoDAO {
	public Produto findById(int id) {
		Produto produto = new Produto();

		try (Connection conn = DatabaseConnector.getConnection();
				PreparedStatement ps = conn.prepareStatement(
						"SELECT id, descricao, preco FROM produto WHERE id = ?")) {
			ps.setInt(1, id);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					produto.setId(rs.getInt("id"));
					produto.setDescricao(rs.getString("descricao"));
					produto.setPreco(rs.getDouble("preco"));
				}
			}
		} catch (SQLException e) {
			throw new DataAccessException(e);
		}

		return produto;
	}

	public List<Produto> findAll() {
		List<Produto> produtos = new ArrayList<>();

		try (Connection conn = DatabaseConnector.getConnection();
				PreparedStatement ps = conn.prepareStatement(
						"SELECT id, descricao, preco FROM produto");
				ResultSet rs = ps.executeQuery()) {
			while (rs.next()) {
				Produto p = new Produto();
				p.setId(rs.getInt("id"));
				p.setDescricao(rs.getString("descricao"));
				p.setPreco(rs.getDouble("preco"));
				produtos.add(p);
			}
		} catch (SQLException e) {
			throw new DataAccessException(e);
		}

		return produtos;
	}

	public int totalItens(String descricao, double precoMinimo, double precoMaximo) {
		int total = 0;

		try (Connection conn = DatabaseConnector.getConnection();
				PreparedStatement ps = conn.prepareStatement(
						"SELECT COUNT(*) FROM produto "
								+ "WHERE descricao LIKE ? "
								+ "	AND preco BETWEEN ? AND ?")) {
			ps.setString(1, "%" + descricao + "%");
			ps.setDouble(2, precoMinimo);
			ps.setDouble(3, precoMaximo);

			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					total = rs.getInt(1);
				}
			}
		} catch (SQLException e) {
			throw new DataAccessException(e);
		}

		return total;
	}

	public List<Produto> findPaged(
			int page, int pageSize,
			String descricao, double precoMinimo, double precoMaximo) {

		List<Produto> produtos = new ArrayList<>();

		try (Connection conn = DatabaseConnector.getConnection();
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

			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					Produto p = new Produto();
					p.setId(rs.getInt("id"));
					p.setDescricao(rs.getString("descricao"));
					p.setPreco(rs.getDouble("preco"));
					produtos.add(p);
				}
			}
		} catch (SQLException e) {
			throw new DataAccessException(e);
		}

		return produtos;
	}

}
