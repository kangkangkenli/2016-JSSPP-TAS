function job_allocation_session()

global ALLOC;
global FLAG; 
global JOB_TIME_Q;
global cur_job;
global total_bin_size;
global START_INPUT;
global RUN_INPUT;
global cur_head;
global buffer_size;
        
while 1 > 0 && cur_job <= min(cur_head + buffer_size, START_INPUT + RUN_INPUT)
        
  if FLAG(cur_job) == 0
  
           normal_allocation(cur_job,JOB_TIME_Q(cur_job));
           
           if FLAG(cur_job) == 1
               

               ALLOC = ALLOC + 1;
              
               cur_job = cur_job + 1;
               
               fprintf('current allocted job number is %d \n', ALLOC);
               fprintf('left total bin size is %d \n\n\n', total_bin_size);
               
           else                
                   
                backfill_allocation(cur_job);
      
           end
           
   else
       % if cur_job has been allocated by backfilling, skip it
      cur_job = cur_job + 1 ;    
  
   end

end
