package movievultures.recommender;

import java.util.Iterator;
import java.util.List;

import javax.sql.DataSource;

import org.apache.mahout.cf.taste.common.TasteException;
import org.apache.mahout.cf.taste.impl.model.jdbc.PostgreSQLJDBCDataModel;
import org.apache.mahout.cf.taste.impl.neighborhood.NearestNUserNeighborhood;
import org.apache.mahout.cf.taste.impl.recommender.CachingRecommender;
import org.apache.mahout.cf.taste.impl.recommender.GenericUserBasedRecommender;
import org.apache.mahout.cf.taste.impl.similarity.PearsonCorrelationSimilarity;
import org.apache.mahout.cf.taste.model.JDBCDataModel;
import org.apache.mahout.cf.taste.neighborhood.UserNeighborhood;
import org.apache.mahout.cf.taste.recommender.RecommendedItem;
import org.apache.mahout.cf.taste.recommender.Recommender;
import org.apache.mahout.cf.taste.similarity.UserSimilarity;
import org.postgresql.ds.PGPoolingDataSource;

import movievultures.model.Movie;
import movievultures.model.User;

public class RecommenderUtils {

	// data model for the recommender
	private JDBCDataModel model;

	// recommender
	// private Recommender recommender;

	public void getRecommendation(long userId) throws TasteException {
		// connect to database
		PGPoolingDataSource connection = new PGPoolingDataSource();
		connection.setDataSourceName("db_name");
		connection.setServerName("localhost");
		connection.setPortNumber(5432);
		connection.setDatabaseName("movievultures");
		connection.setUser("swan");
		connection.setPassword("abcdabcd");
		connection.setMaxConnections(10);

		DataSource movieVults = (DataSource) connection;

		model = new PostgreSQLJDBCDataModel(movieVults, "reviews", "user_userid", "movie_movieid", "rating", "date");

		UserSimilarity userSimilarity = new PearsonCorrelationSimilarity(model);
		UserNeighborhood neighborhood = new NearestNUserNeighborhood(15, userSimilarity, model);
		Recommender recommender = new GenericUserBasedRecommender(model, neighborhood, userSimilarity);
		Recommender cachingRecommender = new CachingRecommender(recommender);
		List<RecommendedItem> recommendations =
				  cachingRecommender.recommend(userId, 5);
		System.out.println("total recommendations: " + recommendations.size());
		Iterator<RecommendedItem>iter = recommendations.iterator();
		while ( iter.hasNext()) {
			RecommendedItem item = iter.next();
			System.out.println("item id: " + item.getItemID());
			System.out.println("value: " + item.getValue() );
		}

	}
	
	public static void main(String[] args) throws TasteException{
		RecommenderUtils ru = new RecommenderUtils();
		ru.getRecommendation(1001);
	}

}
