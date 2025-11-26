```shell
python -u generate_data.py --num_sample 100 \
    --wiki_start_index 0 \
    --prompt_start_index 0 \
    --watermark kgw \
    --key 33554393 \
    --min_length 100\
    --max_length 400\
    --model opt \
    --output_file data/main/kgw_opt.json


python -m seeker.seeker --watermark kgw \
    --targeted_fpr 1e-6 \
    --input_file data/main/kgw_opt_10000.json \
    --output_file baseline_result/seeker_main/kgw_opt.log \
    --window_size 50 \
    --threshold_1 0.5 \
    --threshold_2 0.0 \
    --min_length 100 \
    --max_length 400\
    --model opt \
    --key 33554393


python evaluate.py --watermark kgw \
    --input_file baseline_result/seeker_main/kgw_opt.log \
    --iou_threshold 0.0 \
    --detection_method seeker
```