package Service;

import Utility.Constants;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;

import jakarta.servlet.http.HttpSession;
import model.Movie;
import model.Series;
import model.Video;

import java.time.Year;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;



public class SearchService {
    private static final String SESSION_RESULTS_KEY = "cachedSearchResults";
    private static final String SESSION_QUERY_KEY = "cachedSearchQuery";
    
    private final HttpSession session;
    private String currentQuery;
    private List<Video> currentResults;
    private String currentFilter = "all";

    public SearchService(HttpSession session) {
        this.session = session;
    }

    public List<Video> search(String query, String filterType) throws IOException, InterruptedException {
        this.currentQuery = query;
        this.currentFilter = filterType != null ? filterType : "all";

        
        String cachedQuery = (String) session.getAttribute(SESSION_QUERY_KEY);
        List<Video> cachedResults = getCurrentResults();
        if (cachedResults != null && query.equals(cachedQuery)) {
            System.out.println("Using cached results for query: " + query);
            this.currentResults = cachedResults;
        } else {
            System.out.println("Fetching fresh results for query: " + query);
            this.currentResults = fetchSearchResults(query);
            session.setAttribute(SESSION_RESULTS_KEY, this.currentResults);
            session.setAttribute(SESSION_QUERY_KEY, query);
        }

        return getFilteredResults();
    }

    public List<Video> getFilteredResults() {
        if ("all".equals(currentFilter)) {
            return currentResults;
        }
        
        if ("recent".equals(currentFilter)) {
            int currentYear = Year.now().getValue();
            return currentResults.stream()
                .filter(v -> {
                    try {
                        int videoYear = Integer.parseInt(v.getUplaodDate().split("-")[0]);
                        return videoYear >= (currentYear - 1);
                    } catch (Exception e) {
                        return false;
                    }
                })
                .collect(Collectors.toList());
        }
        
        return currentResults.stream()
            .filter(v -> currentFilter.equals(v.getType()))
            .collect(Collectors.toList());
    }

    public String getCurrentQuery() {
        return currentQuery;
    }

    public String getCurrentFilter() {
        return currentFilter;
    }
    public String getCacheKey() {
        return SESSION_RESULTS_KEY;
    }

    public List<Video> getCurrentResults() {
        if(currentResults == null) {
            @SuppressWarnings("unchecked")
            List<Video> cachedResults = (List<Video>) session.getAttribute(SESSION_RESULTS_KEY);
            if(cachedResults != null) {
                currentResults = cachedResults;
                setCurrentResults(cachedResults);
            } else {
                currentResults = null;
            }
        }
        return currentResults;
    }
    public void setCurrentResults(List<Video> results) {
        this.currentResults = results;
    }


    public int getResultCount() {
        List<Video> filtered = getFilteredResults();
        return filtered != null ? filtered.size() : 0;
    }

    public boolean hasResults() {
        List<Video> filtered = getFilteredResults();
        return filtered != null && !filtered.isEmpty();
    }

    public Video findVideoById(int id) {
        if (currentResults != null) {
            return currentResults.stream()
                .filter(video -> video.getId() == id)
                .findFirst()
                .orElse(null);
        }
        return null;
    }

    private List<Video> fetchSearchResults(String query) throws IOException, InterruptedException {

        
        String apiUrl = Constants.API_URL_SCRAPER;
            HttpClient client = HttpClient.newHttpClient();
            HttpRequest httpRequest = HttpRequest.newBuilder()
                                .uri(URI.create(apiUrl))
                                .header("Accept", "application/json, text/javascript, */*; q=0.01")
                                .header("Accept-Language", "en-US,en;q=0.8")
                                .header("Content-Type", "application/x-www-form-urlencoded; charset=UTF-8")
                                .header("X-Requested-With", "XMLHttpRequest")
                                .header("cookie", Constants.COOKIE)
                                .POST(HttpRequest.BodyPublishers.ofString("q=" + java.net.URLEncoder.encode(query, "UTF-8")))
                                .build();


        System.out.println("Sending request to API with query: " + query);


        HttpResponse<String> apiResponse = client.send(httpRequest, HttpResponse.BodyHandlers.ofString());
        JsonArray objArray;
        try {
            objArray = JsonParser.parseString(apiResponse.body()).getAsJsonObject().get("output").getAsJsonArray();
        } catch (Exception e) {
            return new ArrayList<Video>();
        }

        List<Video> results = new ArrayList<>();

        // Parsing each HTML snippet
        for (int i = 0; i < objArray.size(); i++) {
            String html = objArray.get(i).getAsString();
            Document doc = Jsoup.parse(html);
            Element aTag = doc.selectFirst("a");
            String link = aTag.attr("href");
            String title = aTag.attr("title");
            Element bgGridItem = aTag.selectFirst(".BG--GridItem");
            String image = "";
            if (bgGridItem != null) {
                String styleAttr = bgGridItem.attr("style");
                if (styleAttr.contains("url(")) {
                    image = styleAttr.split("url\\(")[1].split("\\)")[0];
                }
            }

            Video resultObj = new Video();
            resultObj.setId(i); 
            resultObj.setTitle(title);;
            
            if(title.contains("فيلم")) {
                resultObj.setType("movie");;
            } else {
                resultObj.setType("series");
            }
            
            String rating = "N/A";
            resultObj.setRating(rating);
            resultObj.setImageUrl(image);
            
            
            

            Element yearElement = aTag.selectFirst(".year");
            
            String year = yearElement != null ? yearElement.text().replaceAll("[()]", "") : "N/A";

            title = title
                    .replaceAll("(فيلم|مسلسل|مترجم|" + year + "|\\s+)", " ")
                    .trim();

            if( resultObj.getType().equals("series") ) {
                if(title.contains("حلقة")) {
                    continue;
                }
            }

            System.out.println("Fetching additional data for title: " + title);

            String apiUrl_IMDB = Constants.API_URL_IMDB + "t=" + java.net.URLEncoder.encode(title, "UTF-8");
                        HttpClient client_IMDB = HttpClient.newHttpClient();
                        HttpRequest httpRequest_IMDB = HttpRequest.newBuilder()
                                            .uri(URI.create(apiUrl_IMDB))
                                            .header("Accept", "application/json, text/javascript, */*; q=0.01")
                                            .header("Accept-Language", "en-US,en;q=0.8")
                                            .header("Content-Type", "application/x-www-form-urlencoded; charset=UTF-8")
                                            .header("X-Requested-With", "XMLHttpRequest")
                                            .header("cookie", Constants.COOKIE)
                                            .POST(HttpRequest.BodyPublishers.ofString("q=" + java.net.URLEncoder.encode(query, "UTF-8")))
                                            .build();

            HttpResponse<String> apiResponse_IMDB = client_IMDB.send(httpRequest_IMDB, HttpResponse.BodyHandlers.ofString());
            JsonObject objArray_IMDB = JsonParser.parseString(apiResponse_IMDB.body()).getAsJsonObject();

            
            if(objArray_IMDB.get("Response").getAsString().equals("True")) {
                rating = objArray_IMDB.get("imdbRating").getAsString();
                if(rating.equals("N/A")) {
                    rating = "*";
                }
                resultObj.setRating(rating);
                resultObj.setImageUrl(objArray_IMDB.get("Poster").getAsString());
                resultObj.setDescription(objArray_IMDB.get("Plot").getAsString());
                if(resultObj.getType().equals("movie")) {
                    Movie movie = new Movie(resultObj, "", "", "", "", "");
                    String duration = objArray_IMDB.get("Runtime").getAsString().replace("min", "").trim();
                    if( duration.equals("N/A") ){
                        duration = "0";
                    }
                    duration = Integer.toString(Integer.parseInt(duration)/60) + "h " + Integer.toString(Integer.parseInt(duration)%60) + "m";
                    movie.setDuration(duration);
                    String director = objArray_IMDB.get("Director").getAsString();
                    movie.setDirector(director);
                    String genre = objArray_IMDB.get("Genre").getAsString();
                    movie.setGenre(genre);
                    movie.setAgeRating(objArray_IMDB.get("Rated").getAsString());
                    movie.setUplaodDate(year);
                    movie.setLink(link);
                    results.add(movie);
                }else{
                    String totalSeasons = "N/A";
                    if(objArray_IMDB.get("totalSeasons") != null){
                        totalSeasons = objArray_IMDB.get("totalSeasons").getAsString();
                    }
                    Series series = new Series(resultObj, Integer.parseInt(totalSeasons));
                    series.setNumberOfSeasons(Integer.parseInt(totalSeasons));
                    series.setUplaodDate(year);
                    series.setLink(link);
                    results.add(series);
                }
            }
            
        }

        return results;
    }
}
