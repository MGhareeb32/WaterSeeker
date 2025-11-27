N_SAMPLE=100
N_EDIT=6
N_WINDOW=6
TOLERANCE=6
KEY=33554393

# DELTA = 5.5

# N_SAMPLE=100
# N_EDIT=1
# N_WINDOW=25
# TOLERANCE=10
# KEY=33554393
# {'FPR': 0.0, 'FNR': 1.0, 'F1': 0.0, 'Average iou': 0.0}
# (0.0, 1.0)

# N_SAMPLE=100
# N_EDIT=2
# N_WINDOW=25
# TOLERANCE=10
# KEY=33554393
# {'FPR': 0.0, 'FNR': 1.0, 'F1': 0.0, 'Average iou': 0.0}
# (0.0, 1.0)

# N_SAMPLE=100
# N_EDIT=3
# N_WINDOW=25
# TOLERANCE=10
# KEY=33554393
# {'FPR': 0.0, 'FNR': 1.0, 'F1': 0.0, 'Average iou': 0.0}
# (0.0, 1.0)

# N_SAMPLE=100
# N_EDIT=4
# N_WINDOW=25
# TOLERANCE=10
# KEY=33554393
# {'FPR': 0.0, 'FNR': 1.0, 'F1': 0.0, 'Average iou': 0.0}
# (0.0, 1.0)

# N_SAMPLE=100
# N_EDIT=5
# N_WINDOW=25
# TOLERANCE=10
# KEY=33554393
# {'FPR': 0.0, 'FNR': 1.0, 'F1': 0.0, 'Average iou': 0.0}
# (0.0, 1.0)

# N_SAMPLE=100
# N_EDIT=6
# N_WINDOW=25
# TOLERANCE=10
# KEY=33554393
# {'FPR': 0.0, 'FNR': 1.0, 'F1': 0.0, 'Average iou': 0.0}
# (0.0, 1.0)

# N_SAMPLE=100
# N_EDIT=25
# N_WINDOW=25
# TOLERANCE=10
# KEY=33554393
# {'FPR': 0.0, 'FNR': 0.36, 'F1': 0.7804878048780487, 'Average iou': 0.5694360530407824}
# (0.0019839678425341845, 0.36076924204826355)


# DELTA = 2.5

# N_SAMPLE=100
# N_EDIT=1
# N_WINDOW=25
# TOLERANCE=10
# KEY=33554393
# {'FPR': 0.0, 'FNR': 1.0, 'F1': 0.0, 'Average iou': 0.0}
# (0.0, 1.0)

# N_SAMPLE=100
# N_EDIT=2
# N_WINDOW=25
# TOLERANCE=10
# KEY=33554393
# {'FPR': 0.0, 'FNR': 1.0, 'F1': 0.0, 'Average iou': 0.0}
# (0.0, 1.0)

# N_SAMPLE=100
# N_EDIT=3
# N_WINDOW=25
# TOLERANCE=10
# KEY=33554393
# {'FPR': 0.0, 'FNR': 1.0, 'F1': 0.0, 'Average iou': 0.0}
# (0.0, 1.0)

# N_SAMPLE=100
# N_EDIT=4
# N_WINDOW=25
# TOLERANCE=10
# KEY=33554393
# {'FPR': 0.0, 'FNR': 1.0, 'F1': 0.0, 'Average iou': 0.0}
# (0.0, 1.0)

# N_SAMPLE=100
# N_EDIT=5
# N_WINDOW=25
# TOLERANCE=10
# KEY=33554393
# {'FPR': 0.0, 'FNR': 1.0, 'F1': 0.0, 'Average iou': 0.0}
# (0.0, 1.0)

# N_SAMPLE=100
# N_EDIT=6
# N_WINDOW=25
# TOLERANCE=10
# KEY=33554393
# {'FPR': 0.0, 'FNR': 1.0, 'F1': 0.0, 'Average iou': 0.0}
# (0.0, 1.0)

# N_SAMPLE=100
# N_EDIT=25
# N_WINDOW=25
# TOLERANCE=10
# KEY=33554393
# {'FPR': 0.0, 'FNR': 0.9, 'F1': 0.18181818181818182, 'Average iou': 0.07749936854677217}
# (0.00090180360712111, 0.8999999761581421)


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
    --input_file data/main/kgw_opt_500.json \
    --output_file baseline_result/seeker_main/kgw_opt.log \
    --window_size $N_WINDOW \
    --threshold_1 0.5 \
    --threshold_2 0.0 \
    --min_length $N_EDIT\
    --max_length $N_EDIT\
    --tolerance $TOLERANCE\
    --model opt \
    --key $KEY

python evaluate.py --watermark kgw \
    --input_file baseline_result/seeker_main/kgw_opt.log \
    --iou_threshold 0.0 \
    --detection_method seeker