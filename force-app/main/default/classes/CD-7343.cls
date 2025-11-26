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
            when else {
                label = 'Unknown Stage';
            }
        }

        return label;
    }
}
