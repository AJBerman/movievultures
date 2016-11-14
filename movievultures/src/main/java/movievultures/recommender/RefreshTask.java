package movievultures.recommender;

import org.apache.mahout.cf.taste.common.TasteException;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class RefreshTask {

	@Scheduled(cron="* */5 * * * *")
	public void refreshDatabase() throws TasteException{
		System.out.println("Refreshing recommender and dataModel");
		RecommenderUtils recommender = new RecommenderUtils("skip");
		recommender.getCachingRecommender().refresh(null);
		recommender.getDataModel().refresh(null);
	}
}
