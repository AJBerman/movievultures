package movievultures.recommender;

import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.sql.DataSource;

import org.apache.mahout.cf.taste.common.TasteException;
import org.apache.mahout.cf.taste.impl.model.jdbc.PostgreSQLJDBCDataModel;
import org.apache.mahout.cf.taste.impl.model.jdbc.ReloadFromJDBCDataModel;
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
import org.springframework.stereotype.Service;


@Service
public class RecommenderUtils {

	// data model for the recommender
	private ReloadFromJDBCDataModel dataModel;
	PGPoolingDataSource connection;


	public RecommenderUtils() throws TasteException {
		// connect to database
		connection = new PGPoolingDataSource();
		connection.setDataSourceName("db_name");
		connection.setServerName("localhost");
		connection.setPortNumber(5432);
		connection.setDatabaseName("movievultures");
		connection.setUser("swan");
		connection.setPassword("abcdabcd");
		connection.setMaxConnections(10);

		DataSource movieVults = (DataSource) connection;

		JDBCDataModel model = new PostgreSQLJDBCDataModel(movieVults, "reviews", "user_userid", "movie_movieid", "rating", "date");
		
		dataModel = new ReloadFromJDBCDataModel(model);
	}

	public List<Integer> getRecommendation(long userId) throws TasteException {

		UserSimilarity userSimilarity = new PearsonCorrelationSimilarity(dataModel);
		UserNeighborhood neighborhood = new NearestNUserNeighborhood(30, userSimilarity, dataModel);
		Recommender recommender = new GenericUserBasedRecommender(dataModel, neighborhood, userSimilarity);
		Recommender cachingRecommender = new CachingRecommender(recommender);
		List<Integer>recs = new ArrayList<Integer>();
		List<RecommendedItem> recommendations =
				  cachingRecommender.recommend(userId, 6);
		System.out.println("total recommendations: " + recommendations.size());
		Iterator<RecommendedItem>iter = recommendations.iterator();
		while ( iter.hasNext()) {
			RecommendedItem item = iter.next();
			System.out.println("item id: " + item.getItemID());		
			System.out.println("Confidence: " + item.getValue());
		}
		//connection.close();
		for(RecommendedItem item: recommendations)
			recs.add((int) item.getItemID());
		
//		for(Integer id : recs){
//			System.out.println("movie id: " + id);
//		}
		//return recommendations;
		return recs;
	}
	
	//for testing
	public static void main(String[] args) throws TasteException{
		RecommenderUtils ru = new RecommenderUtils();
		System.out.println(new Date());
		//for(int i = 1; i < 669; i++) ru.getRecommendation(i);
		ru.getRecommendation(1001);
		System.out.println(new Date());
	}

}
