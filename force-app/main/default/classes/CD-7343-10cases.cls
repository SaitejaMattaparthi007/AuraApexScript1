public class LargeSwitchCaseExample {

    public static String getStageLabel(Integer stageCode) {
        String label;

        switch on stageCode {
            when 0 {
                label = 'Stage 0 - Initialized';
            }
            when 1 {
                label = 'Stage 1 - Queued';
            }
            when 2 {
                label = 'Stage 2 - In Progress';
            }
            when 3 {
                label = 'Stage 3 - Validation';
            }
            when 4 {
                label = 'Stage 4 - Code Review';
            }
            when 5 {
                label = 'Stage 5 - Security Scan';
            }
            when 6 {
                label = 'Stage 6 - Packaging';
            }
            when 7 {
                label = 'Stage 7 - Deployment';
            }
            when 8 {
                label = 'Stage 8 - Post Deployment Tests';
            }
            when 9 {
                label = 'Stage 9 - Monitoring';
            }
            when 10 {
                label = 'Stage 10 - Completed';
            }
            when 11 {
                label = 'Stage 11 - Archived';
            }
            when 12 {
                label = 'Stage 12 - Cleanup';
            }
            when else {
                label = 'Unknown Stage';
            }
        }

        return label;
    }
}
