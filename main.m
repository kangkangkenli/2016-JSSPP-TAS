function main()
global CAL;
CAL = 194480;
global ALLOC;
ALLOC = 0;
global TIME;
TIME = 0;
global FLAG; 
FLAG = zeros(1,CAL);
global scale;
scale = 24;
global cycle;
cycle = 15;
global UTL;
UTL= zeros(1,CAL);
global backfill_thres;
backfill_thres = 50;
global JOB_SIZE_Q;
global JOB_TIME_Q;
global T;
global N;
global T_1;
global N_1;

data();



JOB_SIZE_Q = N_1;
JOB_TIME_Q = T_1;

for i = 1: 96
    JOB_SIZE_Q = [JOB_SIZE_Q,N];
    JOB_TIME_Q = [JOB_TIME_Q,T];
end

global JOB_ID;
global S;

JOB_ID = zeros(scale,scale,scale);
S = zeros(scale,scale,scale,2);

global cur_job;
cur_job = 1;
global START_INPUT;
global RUN_INPUT;
START_INPUT = 1520;
RUN_INPUT = 2010;
global buffer_size;
buffer_size = 500;
global cur_head;


% initial placement, start the system around half occupied    
free_partition_detection();

while ALLOC <= START_INPUT && cur_job <= START_INPUT
    
    first_bin_placement(1,cur_job,JOB_TIME_Q(cur_job));

    if FLAG(cur_job) == 1
        ALLOC = ALLOC + 1; 
        cur_job = cur_job + 1; 
        fprintf('current allocted job number is %d \n\n\n', ALLOC);
    else
        break;
    end

end


while cur_job <= START_INPUT + RUN_INPUT

 fprintf('current time is %d \n', TIME);
 fprintf('current iteration of allocation is %d \n', TIME/cycle+1);
 
  cur_head = cur_job;
 
    while cur_job <= min(cur_head + buffer_size, START_INPUT + RUN_INPUT)
        
        if mod(TIME,cycle) == 0
        
            free_partition_detection();
            job_allocation_session();


        end
     
     system_queue_update();
    end
end

UTL(length(UTL)) =[];
fprintf('UTL is \n');
disp(UTL);
dlmwrite('UTL_window.txt',UTL,'delimiter', '\t');


               
               
               
               
            