using System.Net;
using Npgsql;
using System.Data;
using System.Text;
using System.Web;



Dictionary<string, string> pages = new Dictionary<string, string>()
{
    { "/main", "index.html" },
    {  "/get-out", "movie-page.html"},
};


static async Task<string> GetFromDatabase()
{

    var result = new
    {
        moviesData = new List<object>(),
        genres = new List<object>(),
        actors = new List<object>(),
        genre_movie_is = new List<object>(),
    };



string strConnection = "Host=localhost; Port=5432; Database = movies_database; User Id = postgres; Password = catboy; ";
    await using var dataSource = NpgsqlDataSource.Create(strConnection);

    var command = dataSource.CreateCommand("SELECT * FROM GENRE_LIST");
    var reader = await command.ExecuteReaderAsync();

    while (await reader.ReadAsync())
    {
        result.genres.Add(new
        {
            id = reader.GetInt32(0),
            genre = reader.GetString(1)
        });

    }

    command = dataSource.CreateCommand($"SELECT * FROM movies");
    reader = await command.ExecuteReaderAsync();

    while (await reader.ReadAsync())
    {
        result.moviesData.Add(new
        {
            id = reader.GetInt32(0),
            name = reader.GetString(1),
            image = reader.GetString(2),
            vid_link = reader.GetValue(3),
            year = reader.GetValue(4),
            description = reader.GetValue(5),
            len = reader.GetValue(6)
        });
    }

    command = dataSource.CreateCommand("SELECT actor_name FROM actor_names where id in (SELECT actor_id from actor_movie_relations WHERE movie_id = 4)");
    reader = await command.ExecuteReaderAsync();

    while (await reader.ReadAsync())
    {
        result.actors.Add(
            new
            {
                actor = reader.GetString(0)
            });
    }

    command = dataSource.CreateCommand("SELECT genre_name FROM genre_list where genre_id in (SELECT genre_id from genre_movie_relations WHERE movie_id = 4)");
    reader = await command.ExecuteReaderAsync();

    while (await reader.ReadAsync())
    {
        result.genre_movie_is.Add(
            new
            {
                genre = reader.GetString(0)
            });
    }

    return System.Text.Json.JsonSerializer.Serialize(result);
}

static async Task<string> GetMovie(int mov_id) 
{

    var result = new
    {
        moviesData = new List<object>(),
        actors = new List<object>(),
        genre_movie_is = new List<object>()
    };



    string strConnection = "Host=localhost; Port=5432; Database = movies_database; User Id = postgres; Password = catboy; ";
    await using var dataSource = NpgsqlDataSource.Create(strConnection);

    var command = dataSource.CreateCommand($"SELECT * FROM movies WHERE movie_id = {mov_id}");
    var reader = await command.ExecuteReaderAsync();

    while (await reader.ReadAsync())
    {
        result.moviesData.Add(new
        {
            id = reader.GetInt32(0),
            name = reader.GetString(1),
            image = reader.GetString(2),
            vid_link = reader.GetValue(3),
            year = reader.GetValue(4),
            description = reader.GetValue(5),
            len = reader.GetValue(6)
        });
    }


    command = dataSource.CreateCommand($"Select actor_name From actor_names as actors\r\nleft join actor_movie_relations as lin on  lin.actor_id = actors.id Where movie_id = {mov_id}");
    reader = await command.ExecuteReaderAsync();

    while (await reader.ReadAsync())
    {
        result.actors.Add(
            new
            {
                actor = reader.GetString(0)
            });
    }

    command = dataSource.CreateCommand($"SELECT genre_name FROM genre_list where genre_id in (SELECT genre_id from genre_movie_relations WHERE movie_id = {mov_id})");
    reader = await command.ExecuteReaderAsync();

    while (await reader.ReadAsync())
    {
        result.genre_movie_is.Add(
            new
            {
                genre = reader.GetString(0)
            });
    }

    return System.Text.Json.JsonSerializer.Serialize(result);
}


HttpListener server = new HttpListener();
server.Prefixes.Add("http://127.0.0.1:8888/");
server.Start();

while (true)
{
    var context = await server.GetContextAsync();

    var response = context.Response;
    var request = context.Request;

    if (request.Url.AbsolutePath == "/movies")
    {
        string movieJson = await GetFromDatabase();
        byte[] buff = Encoding.UTF8.GetBytes(movieJson);
        response.ContentType = "application/json";
        response.ContentLength64 = buff.Length;
        await response.OutputStream.WriteAsync(buff, 0, buff.Length);
    }
    else if (request.Url.AbsolutePath == "/individual") 
    {
        Console.WriteLine(request.Url.AbsolutePath);
        var query = request.Url.Query;
        if (int.TryParse(HttpUtility.ParseQueryString(request.Url.Query).Get("movie_id"), out var id_of_movie))
        {
            string movieJson = await GetMovie(id_of_movie);
            byte[] buff = Encoding.UTF8.GetBytes(movieJson);
            response.ContentType = "application/json";
            response.ContentLength64 = buff.Length;
            await response.OutputStream.WriteAsync(buff, 0, buff.Length);
        }
  
    }
    else
    {

        var url = request.Url;
        Console.WriteLine(request.RawUrl);

        try
        {
            
            var extension = Path.GetExtension(url.AbsolutePath);
            string responseText;
            if (extension == "")
            {
                if (request.RawUrl == "/main")
                {
                    responseText = File.ReadAllText(Directory.GetCurrentDirectory() + "\\gid_page\\" + "index.html");
                }
                else
                {
                    responseText = File.ReadAllText(Directory.GetCurrentDirectory() + "\\gid_page\\" + "movie-page.html");
                }
            }

            
            else
            {
                responseText = File.ReadAllText(Directory.GetCurrentDirectory() + "\\gid_page\\" + request.RawUrl);
            }

            
            Console.WriteLine(extension+ " this is the extention");
            if (extension == ".svg")
            {
                response.ContentType = "image/svg+xml";
            }
            if (extension == ".png")
            {
                response.ContentType = "image/png";
            }
            if (extension == ".ico")
            {
                response.ContentType = "image/x-icon";
            }
            if (extension == ".css")
            {
                response.ContentType = "text/css";
            }

            if (extension == ".js")
            {
                response.ContentType = "text/js";
            }
            if (extension == ".webp")
            {
                response.ContentType = "image/webp";
                Console.WriteLine("wiiiiiiiii");
            }
            else
            {
                response.ContentType = "text/html";
            }

            byte[] buffer = Encoding.UTF8.GetBytes(responseText);
            response.ContentLength64 = buffer.Length;
            using Stream output = response.OutputStream;
            await output.WriteAsync(buffer);
            await output.FlushAsync();

            Console.WriteLine("Запрос обработан");
        }
        catch (Exception exc)
        {
            Console.WriteLine(exc);
            Console.WriteLine("awkwaaaaard");
            response.Close();
        }


    }
}
