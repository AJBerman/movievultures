package movievultures.recommender;

import org.apache.mahout.cf.taste.common.TasteException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class RefreshTask {
	
	@Autowired
	RecommenderUtils recommender;

	@Scheduled(cron="0 */5 * * * *")
	public void refreshDatabase() throws TasteException{
		System.out.println("Refreshing recommender and dataModel");
		recommender.getCachingRecommender().refresh(null);
	}
}
