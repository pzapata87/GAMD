using System.Data;
using EDOSwit.Entity;
using GAMD.Business.Entity;
using Microsoft.Practices.EnterpriseLibrary.Data;

namespace GAMD.DataAccess
{
    public class UsuarioRepository : Singleton<UsuarioRepository>
    {
        #region Attributos

        private readonly Database _database = new DatabaseProviderFactory().Create("DefaultConnection");

        #endregion

        #region Métodos

        public Usuario GetUser(string username, string password)
        {
            Usuario usuario = null;

            using (var comando = _database.GetStoredProcCommand("Get_User"))
            {
                _database.AddInParameter(comando, "@Username", DbType.String, username);
                _database.AddInParameter(comando, "@Password", DbType.String, password);

                using (var lector = _database.ExecuteReader(comando))
                {
                    if (lector.Read())
                    {
                        usuario = new Usuario
                        {
                            Id = lector.GetInt32(lector.GetOrdinal("Id")),
                            Username = lector.GetString(lector.GetOrdinal("Username")),
                            TipoUsuario = lector.GetInt32(lector.GetOrdinal("TipoUsuario")),
                            Persona = new Persona
                            {
                                Nombre = lector.GetString(lector.GetOrdinal("Nombre")),
                                Apellido = lector.GetString(lector.GetOrdinal("Apellido"))
                            },
                            Estado = lector.GetInt32(lector.GetOrdinal("Estado"))
                        };
                    }
                }
            }

            return usuario;
        }

        #endregion
    }
}