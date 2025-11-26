N_SAMPLE=10
N_EDIT=25
N_WINDOW=25
KEY=33554393

# N_SAMPLE=10
# N_EDIT=25
# N_WINDOW=25
# KEY=33554393
# {'FPR': 0.0, 'FNR': 0.9, 'F1': 0.18181818181818182, 'Average iou': 0.052083333333333336}
# N_SAMPLE=10
# N_EDIT=25
# N_WINDOW=25
# KEY=33554393
# {'FPR': 0.0, 'FNR': 0.9, 'F1': 0.18181818181818182, 'Average iou': 0.07352941176470588}
# N_SAMPLE=10
# N_EDIT=25
# N_WINDOW=100
# KEY=33554393
# {'FPR': 0.0, 'FNR': 0.9, 'F1': 0.18181818181818182, 'Average iou': 0.09615384615384616}

# N_SAMPLE=10
# N_EDIT=50
# N_WINDOW=100
# KEY=33554393
# {'FPR': 0.0, 'FNR': 0.4, 'F1': 0.7499999999999999, 'Average iou': 0.5336119250845324}
# N_SAMPLE=10
# N_EDIT=50
# N_WINDOW=25
# KEY=33554393
# {'FPR': 0.0, 'FNR': 0.6, 'F1': 0.5714285714285715, 'Average iou': 0.2910286336756925}
# N_SAMPLE=10
# N_EDIT=50
# N_WINDOW=50
# KEY=33554393
# {'FPR': 0.0, 'FNR': 0.3, 'F1': 0.8235294117647058, 'Average iou': 0.6625154990526799}

# N_SAMPLE=10
# N_EDIT=100
# N_WINDOW=50
# KEY=33554393
# {'FPR': 0.0, 'FNR': 0.0, 'F1': 1.0, 'Average iou': 0.9088844470751312}

python -u generate_data.py --num_sample $N_SAMPLE \
    --wiki_start_index 0 \
    --prompt_start_index 0 \
    --watermark kgw \
    --key $KEY \
    --min_length $N_EDIT\
    --max_length $N_EDIT\
    --model opt \
    --output_file data/main/kgw_opt.json

python -m seeker.seeker --watermark kgw \
    --targeted_fpr 0.1 \
    --input_file data/main/kgw_opt_10000.json \
    --output_file baseline_result/seeker_main/kgw_opt.log \
    --window_size $N_WINDOW \
    --threshold_1 0.5 \
    --threshold_2 0.0 \
    --min_length $N_EDIT\
    --max_length $N_EDIT\
    --model opt \
    --key $KEY

python evaluate.py --watermark kgw \
    --input_file baseline_result/seeker_main/kgw_opt.log \
    --iou_threshold 0.0 \
    --detection_method seeker