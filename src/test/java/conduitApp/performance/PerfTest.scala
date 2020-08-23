package performance

import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef._
import scala.concurrent.duration._

class PerfTest extends Simulation {

  val protocol = karateProtocol(
    "/api/articles/{articleId}" -> Nil
  )

//   protocol.nameResolver = (req, ctx) => req.getHeader("karate-name")

  val createArticle = scenario("Create and delete article").exec(karateFeature("classpath:conduitApp/performance/createArticle.feature"))

  setUp(
    createArticle.inject(
        atOnceUsers(3)
        ).protocols(protocol)
  )

}